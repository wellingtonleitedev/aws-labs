using Amazon;
using Amazon.DynamoDBv2;
using Amazon.DynamoDBv2.DocumentModel;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
// Learn more about configuring OpenAPI at https://aka.ms/aspnet/openapi
builder.Services.AddOpenApi();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.MapOpenApi();
}

app.MapGet("/", () => "Healthcheck: Healthy");

app.MapGet("/weatherforecast", async (string location = "Dallas") =>
{
    var forecast = new List<WeatherForecast>();
    
    try
    {
        var client = new AmazonDynamoDBClient(RegionEndpoint.USEast2);
        ITable table = Table.LoadTable(client, "Weather");

        var filter = new ScanFilter();
        filter.AddCondition("Location", ScanOperator.Equal, location);

        var scanConfig = new ScanOperationConfig()
        {
            Filter = filter,
            Select = SelectValues.SpecificAttributes,
            AttributesToGet = new List<string> { "Location", "Timestamp", "TempC", "TempF", "Summary" }
        };

        ISearch search = table.Scan(scanConfig);

        List<Document> matches;

        do
        {
            matches = await search.GetNextSetAsync();
            foreach(var match in matches)
            {
                forecast.Add(new WeatherForecast(Convert.ToDateTime(match["Timestamp"]), Convert.ToInt32(match["TempC"]), $"{match["Summary"]}!"));
            }
        } while (!search.IsDone);
    }
    catch(Exception ex)
    {
        throw new Exception("Error retrieving weather data", ex);
    }

    return forecast.ToArray();
})
.WithName("GetWeatherForecast");

app.Run();

record WeatherForecast(DateTime Date, int TemperatureC, string? Summary)
{
    public int TemperatureF => 32 + (int)(TemperatureC / 0.5556);
}
