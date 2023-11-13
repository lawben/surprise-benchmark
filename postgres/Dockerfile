# To build this image, in the postgres/ directory, run:
#   docker build -t surprise-benchmark-postgres .
#
# and to run it:
#   docker run -v $(pwd)/../results/postgres:/results surprise-benchmark-postgres

# This is the system that we pass to Benchbase.
# Supported system's in benchbase are, e.g., postgres or mysql.
ARG BB_SYSTEM=postgres

#####################################
### DO NOT CHANGE THIS BUILD STEP ###
#####################################
# This part of the setup should not be changed. It just builds Benchbase.
FROM eclipse-temurin:17 as benchbase
ARG BB_SYSTEM
RUN apt-get update && apt-get install -y git
RUN git clone --depth 1 --single-branch https://github.com/cmu-db/benchbase.git
RUN cd benchbase && ./mvnw clean package -P $BB_SYSTEM -DskipTests && \
    cd target && tar xvzf benchbase-$BB_SYSTEM.tgz


##########################################
### CHANGE BELOW HERE / INSTALL SYSTEM ###
##########################################
# This part of the build should be changed for each system that we test.
# These first few lines just make sure that we copy the Benchbase jar.
# Depending on the system, you might need to change the `FROM x` part here.
FROM postgres:16 as benchmark_executor
### Do not change these lines. ###
ARG BB_SYSTEM
COPY --from=benchbase /benchbase/target/benchbase-$BB_SYSTEM/ /benchbase

##############################################
### ADD CUSTOM STUFF FOR SYSTEM BELOW HERE ###
##############################################

# RUN ...

################################
### DO NOT CHANGE BELOW HERE ###
################################
# Install Java Runtime to execute benchbase.jar
RUN apt-get update && apt-get install -y openjdk-17-jre

# Copy config files
COPY init_tpch_config.xml /benchbase/config/init_tpch_config.xml
COPY surprise_tpch_config.xml /benchbase/config/surprise_tpch_config.xml
COPY surprise_tpch_queries.xml /benchbase/config/surprise_tpch_queries.xml
COPY --chmod=744 setup_system.sh /setup_system.sh
COPY --chmod=744 run_benchmark.sh /benchbase/run_benchmark.sh
WORKDIR /benchbase
ENTRYPOINT /setup_system.sh && /benchbase/run_benchmark.sh
