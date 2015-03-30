# Nginx S3 File Upload Proxy
S3 file upload proxy using Nginx, complete with AWS authentication.

## Installation

Create a `.env` file to hold your environment variables for Nginx. It should contain the following:
```bash
AWS_ACCESS_KEY_ID=YOURAWSACCESSKEYID
AWS_SECRET_ACCESS_KEY=YOURAWSSECRETACCESSKEY
S3_BUCKET_NAME=YOURS3BUCKETNAME
```

Using Docker, build the image.
```bash
$ docker build -t jamescmartinez/nginx-s3-upload .
```

After the image is built, create a container.
```bash
$ docker run -d -p 80:80 --env-file=.env jamescmartinez/nginx-s3-upload
```

## Usage

Once the container is running, give it a try!
```bash
$ curl -T path/to/file/to/upload http://nginx-s3-upload.yourdomain.com/uploads/entity/property/filename.extension
```

The response will contain a header, `X-File-URL`, with the location of the file on your S3 bucket.

## Contributing

Issue a pull request and I will love you forever.

## License

nginx-s3-upload is released under the MIT license.
