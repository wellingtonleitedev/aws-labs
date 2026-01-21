resource "aws_dynamodb_table" "weather_table" {
  name           = "Weather"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "Location"
  range_key      = "Timestamp"

  attribute {
    name = "Location"
    type = "S"
  }

  attribute {
    name = "Timestamp"
    type = "S"
  }

  tags = {
    Name        = "dynamodb-weather-table"
    Environment = "production"
  }
}

resource "aws_dynamodb_table_item" "weather_item_1" {
  table_name = aws_dynamodb_table.weather_table.name
  hash_key   = aws_dynamodb_table.weather_table.hash_key
  range_key  = aws_dynamodb_table.weather_table.range_key

  item = jsonencode({
    "Location" : {
      "S" : "Dallas"
    },
    "Timestamp" : {
      "S" : "2022-07-23T06:00:00"
    },
    "Summary" : {
      "S" : "Hot"
    },
    "TempC" : {
      "N" : "33"
    },
    "TempF" : {
      "N" : "92"
    }
  })
}

resource "aws_dynamodb_table_item" "weather_item_2" {
  table_name = aws_dynamodb_table.weather_table.name
  hash_key   = aws_dynamodb_table.weather_table.hash_key
  range_key  = aws_dynamodb_table.weather_table.range_key

  item = jsonencode({
    "Location" : {
      "S" : "Dallas"
    },
    "Timestamp" : {
      "S" : "2022-07-23T12:00:00"
    },
    "Summary" : {
      "S" : "Scorching"
    },
    "TempC" : {
      "N" : "43"
    },
    "TempF" : {
      "N" : "109"
    }
  })
}

resource "aws_dynamodb_table_item" "weather_item_3" {
  table_name = aws_dynamodb_table.weather_table.name
  hash_key   = aws_dynamodb_table.weather_table.hash_key
  range_key  = aws_dynamodb_table.weather_table.range_key

  item = jsonencode({
    "Location" : {
      "S" : "Dallas"
    },
    "Timestamp" : {
      "S" : "2022-07-23T18:00:00"
    },
    "Summary" : {
      "S" : "Hot"
    },
    "TempC" : {
      "N" : "36"
    },
    "TempF" : {
      "N" : "97"
    }
  })
}

resource "aws_dynamodb_table_item" "weather_item_4" {
  table_name = aws_dynamodb_table.weather_table.name
  hash_key   = aws_dynamodb_table.weather_table.hash_key
  range_key  = aws_dynamodb_table.weather_table.range_key

  item = jsonencode({
    "Location" : {
      "S" : "Minneapolis"
    },
    "Timestamp" : {
      "S" : "2022-07-23T06:00:00"
    },
    "Summary" : {
      "S" : "Cool"
    },
    "TempC" : {
      "N" : "13"
    },
    "TempF" : {
      "N" : "56"
    }
  })
}

resource "aws_dynamodb_table_item" "weather_item_5" {
  table_name = aws_dynamodb_table.weather_table.name
  hash_key   = aws_dynamodb_table.weather_table.hash_key
  range_key  = aws_dynamodb_table.weather_table.range_key

  item = jsonencode({
    "Location" : {
      "S" : "Minneapolis"
    },
    "Timestamp" : {
      "S" : "2022-07-23T12:00:00"
    },
    "Summary" : {
      "S" : "Balmy"
    },
    "TempC" : {
      "N" : "22"
    },
    "TempF" : {
      "N" : "72"
    }
  })
}

resource "aws_dynamodb_table_item" "weather_item_6" {
  table_name = aws_dynamodb_table.weather_table.name
  hash_key   = aws_dynamodb_table.weather_table.hash_key
  range_key  = aws_dynamodb_table.weather_table.range_key

  item = jsonencode({
    "Location" : {
      "S" : "Minneapolis"
    },
    "Timestamp" : {
      "S" : "2022-07-23T18:00:00"
    },
    "Summary" : {
      "S" : "Balmy"
    },
    "TempC" : {
      "N" : "19"
    },
    "TempF" : {
      "N" : "67"
    }
  })
}