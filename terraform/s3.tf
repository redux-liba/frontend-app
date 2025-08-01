
resource "aws_s3_bucket" "react_site" {
  bucket = "liba-react-s3"

   tags = {
    Name        = "liba_s3"
  }

  website {
    index_document = "index.html"
    error_document = "error.html"
  }

}

  resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.react_site.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "liba_versioning" {
  bucket = aws_s3_bucket.react_site.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "liba_encryption" {
  bucket = aws_s3_bucket.react_site.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
