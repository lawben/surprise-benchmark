# To build this image, in the clickhouse/ directory, run:
#   docker build -t surprise-benchmark-clickhouse .

# This is the system that we pass to Benchbase.
# Supported system's in benchbase are, e.g., postgres or mysql.
ARG BB_SYSTEM=clickhouse

#####################################
### DO NOT CHANGE THIS BUILD STEP ###
#####################################
# This part of the setup should not be changed. It just builds Benchbase.
FROM eclipse-temurin:17 as benchbase
ARG BB_SYSTEM
RUN apt-get -qq update && apt-get -qq install -y git > /dev/null
RUN git clone --depth 1 --single-branch -b surprise https://github.com/lawben/benchbase.git && \
    cd benchbase && ./mvnw clean package -P $BB_SYSTEM --no-transfer-progress -T 1C -DskipTests && \
    cd target && tar xzf benchbase-$BB_SYSTEM.tgz


##########################################
### CHANGE BELOW HERE / INSTALL SYSTEM ###
##########################################
# This part of the build should be changed for each system that we test.
# These first few lines just make sure that we copy the Benchbase jar.
FROM clickhouse/clickhouse-server:23 as benchmark_executor

################################
### DO NOT CHANGE BELOW HERE ###
################################
# Depending on the system, you might need to change the `FROM x` part here.
ARG BB_SYSTEM
COPY --from=benchbase /benchbase/target/benchbase-$BB_SYSTEM/ /benchbase
# Install Java Runtime to execute benchbase.jar
RUN apt-get -qq update && apt-get -qq install -y openjdk-17-jre > /dev/null

# Copy config files
COPY init_tpch_config.xml /benchbase/config/init_tpch_config.xml
COPY run_tpch_config.xml /benchbase/config/run_tpch_config.xml
COPY surprise_tpch_config.xml /benchbase/config/surprise_tpch_config.xml
COPY --chmod=744 setup_system.sh /scripts/setup_system.sh
WORKDIR /benchbase
ENTRYPOINT /scripts/setup_system.sh && /scripts/run_benchmark.sh

##############################################
### ADD CUSTOM STUFF FOR SYSTEM BELOW HERE ###
##############################################

# RUN ...
COPY ddl-clickhouse.sql /benchbase/config/ddl-clickhouse.sql
COPY clickhouse_tpch_queries.xml /benchbase/config/clickhouse_tpch_queries.xml
