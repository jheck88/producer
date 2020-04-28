# Overview

This repository builds a container with NGINX and Real Time Message Protocol (RTMP). 
It's configured with 6 streams.

To run the container run:

```docker run -p 8080:8080 -p 1935:1935 --name producer sinisterrook/producer ```

you can check status at:

```http://localhost:8080/stat```

and stream to and from:

```rtmp://localhost/stream1```