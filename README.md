# Docker image for jQuery UI Download / Theme Builder

Docker image for running https://github.com/jquery/download.jqueryui.com/


## Requirements

* Docker installation with `docker-compose`


## How to use

Just run `docker-compose up --detach --build`

Open http://localhost in your browswer


## Notes

* Use `docker-compose down --rmi local -v` before `up` to ensure a fresh build with new dependencies
