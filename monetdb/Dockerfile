# To build this image, in the monetdb/ directory, run:
#   docker build -t surprise-benchmark-monetdb .

# Note that this will delete the container after running to clean up.
# Reove the `--rm` argument to prevent this.


# This is the system that we pass to Benchbase.
# Supported system's in benchbase are, e.g., postgres or mysql.
ARG BB_SYSTEM=monetdb

#####################################
### DO NOT CHANGE THIS BUILD STEP ###
#####################################
# This part of the setup should not be changed. It just builds Benchbase.
FROM eclipse-temurin:17 as benchbase
ARG BB_SYSTEM
RUN apt-get update && apt-get install -y git
RUN git clone --depth 1 --single-branch -b surprise https://github.com/lawben/benchbase.git && \
    cd benchbase && ./mvnw clean package -P $BB_SYSTEM -DskipTests && \
    cd target && tar xvzf benchbase-$BB_SYSTEM.tgz


##########################################
### CHANGE BELOW HERE / INSTALL SYSTEM ###
##########################################
# This part of the build should be changed for each system that we test.
# These first few lines just make sure that we copy the Benchbase jar.
# Depending on the system, you might need to change the `FROM x` part here.
FROM monetdb/monetdb:Jun2023-SP2 as benchmark_executor
### Do not change these lines. ###
ARG BB_SYSTEM
COPY --from=benchbase /benchbase/target/benchbase-$BB_SYSTEM/ /benchbase

##############################################
### ADD CUSTOM STUFF FOR SYSTEM BELOW HERE ###
##############################################

# RUN ...
COPY ddl-monetdb.sql /benchbase/config/ddl-monetdb.sql

################################
### DO NOT CHANGE BELOW HERE ###
################################
# Install Java Runtime to execute benchbase.jar
RUN yum install -y java-17-openjdk

# Copy config files
COPY init_tpch_config.xml /benchbase/config/init_tpch_config.xml
COPY surprise_tpch_config.xml /benchbase/config/surprise_tpch_config.xml
COPY --chmod=744 setup_system.sh /scripts/setup_system.sh
WORKDIR /benchbase
ENTRYPOINT /scripts/setup_system.sh && /scripts/run_benchmark.sh
