# To build this image, in the mysql/ directory, run:
#   docker build -t surprise-benchmark-mysql .

# This is the system that we pass to Benchbase.
# Supported system's in benchbase are, e.g., postgres or mysql.
ARG BB_SYSTEM=mysql

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


##########################################
### CHANGE BELOW HERE / INSTALL SYSTEM ###
##########################################
# This part of the build should be changed for each system that we test.
# These first few lines just make sure that we copy the Benchbase jar.
FROM mysql:8.0-debian as benchmark_executor

################################
### DO NOT CHANGE BELOW HERE ###
################################
# Depending on the system, you might need to change the `FROM x` part here.
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

# RUN ...

