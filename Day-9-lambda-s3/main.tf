resource "aws_s3_bucket" "name" {
        bucket = "kangane"
        region = "ap-south-1"
}



#  Upload local Lambda ZIP file to S3
resource "aws_s3_object" "name" {
        bucket = aws_s3_bucket.name.id
        key = "lambda_function.zip"
        source = "lambda_function.zip"
        etag = filemd5("lambda_function.zip")
        depends_on = [ aws_s3_bucket.name ]
}


resource "aws_iam_role" "lambda_exec_role" {
  name = "lambda-exec-role-s3-example"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "name" {
        role = aws_iam_role.lambda_exec_role.name
        policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_lambda_function" "name" {
        function_name = "s3_lambda"
        role = aws_iam_role.lambda_exec_role.arn
        s3_bucket = aws_s3_bucket.name.bucket
        s3_key = aws_s3_object.name.key
        handler = "lambda_function.lambda_handler"
        runtime = "python3.9"
        timeout = 900
        memory_size = 128

        source_code_hash = filebase64sha256("lambda_function.zip")

        depends_on = [ aws_s3_bucket.name ]
}
