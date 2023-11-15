# To build this image, in the umbra/ directory, run:
#   docker build -t surprise-benchmark-umbra .

# This is the system that we pass to Benchbase.
# Supported system's in benchbase are, e.g., postgres or mysql.
# Umbra supports the Postgres Wire format, so we can use it.
ARG BB_SYSTEM=postgres

#####################################
### DO NOT CHANGE THIS BUILD STEP ###
#####################################
# This part of the setup should not be changed. It just builds Benchbase.
FROM eclipse-temurin:17 as benchbase
ARG BB_SYSTEM
RUN apt-get update && apt-get install -y git
RUN git clone --depth 1 --single-branch -b surprise https://github.com/lawben/benchbase.git && \
    cd benchbase && ./mvnw clean package -P $BB_SYSTEM --no-transfer-progress -DskipTests && \
    cd target && tar xzf benchbase-$BB_SYSTEM.tgz


##########################
### BUILD SYSTEM IMAGE ###
##########################
# This part of the build should be changed for each system that we test.
# Depending on the system, you might need to change the `FROM x` part here.
FROM ubuntu:22.04 as benchmark_executor

################################
### DO NOT CHANGE BELOW HERE ###
################################
# These first few lines just make sure that we copy the Benchbase jar.
ARG BB_SYSTEM
COPY --from=benchbase /benchbase/target/benchbase-$BB_SYSTEM/ /benchbase
# Install Java Runtime to execute benchbase.jar
RUN apt-get update && apt-get install -y openjdk-17-jre

# Copy config files
COPY init_tpch_config.xml /benchbase/config/init_tpch_config.xml
COPY surprise_tpch_config.xml /benchbase/config/surprise_tpch_config.xml
COPY --chmod=744 setup_system.sh /scripts/setup_system.sh
WORKDIR /benchbase
ENTRYPOINT /scripts/setup_system.sh && /scripts/run_benchmark.sh

##############################################
### ADD CUSTOM STUFF FOR SYSTEM BELOW HERE ###
##############################################
# We don't push the Umbra binary to GitHub, so make sure your local copy is in the surprise-benchmark/umbra/umbra_bin directory.
# Make sure this contains the bin/ and lib/ directories.
RUN apt-get update && apt-get install -y postgresql-client
COPY umbra_bin/ /umbra
COPY ddl-umbra.sql /benchbase/config/ddl-umbra.sql

