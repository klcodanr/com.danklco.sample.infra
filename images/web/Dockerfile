#
#		 Licensed to the Apache Software Foundation (ASF) under one or more contributor license
#        agreements. See the NOTICE file distributed with this work for additional information
#        regarding copyright ownership. The ASF licenses this file to you under the Apache License,
#        Version 2.0 (the "License"); you may not use this file except in compliance with the
#        License. You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0
#        Unless required by applicable law or agreed to in writing, software distributed under the
#        License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND,
#        either express or implied. See the License for the specific language governing permissions
#        and limitations under the License.

# Pull base image.
FROM httpd:alpine

LABEL org.opencontainers.image.source https://github.com/${GH_OWNER}/${ARTIFACT_ID}

RUN apk add apache2-utils

# Configure sites
COPY conf/*  /usr/local/apache2/conf
RUN mkdir /usr/local/apache2/conf.d
COPY conf.d/*  /usr/local/apache2/conf.d/
COPY 503.html /var/www/sample/

# Create required directories
RUN mkdir -p /var/cache/apache2/sample && \
    mkdir -p /var/www/vhosts/sample && \
    mkdir -p /var/www/vhosts/ccrm

# Expose endpoints
EXPOSE 80 443

# Start Apache httpd
RUN /usr/local/apache2/bin/htcacheclean -d60 -p/ -l500M
CMD ["/usr/local/apache2/bin/apachectl", "-DFOREGROUND"]
