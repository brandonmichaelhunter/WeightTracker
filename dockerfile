FROM mcr.microsoft.com/mssql/server:2019-latest
ENV ACCEPT_EULA=Y
ENV SA_PASSWORD=<password>
ENV MSSQL_PID=Standard
ENV MSSQL_TCP_PORT=1433
ENV MSSQL_IP_ADDRESS 0.0.0.0 
WORKDIR /sqlscripts   
WORKDIR /src
       
COPY WeightTrackerDB.sql /sqlscripts/ 
RUN ps -aux        
EXPOSE 1433       
RUN /opt/mssql/bin/sqlservr --accept-eula & (echo "awaiting server bootup" && sleep 15 && echo "lets try to logon"  && /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P '<password>' -d master -i /sqlscripts/WeightTrackerDB.sql )

# docker build -t weighttracker:v2 .
# docker run -p 1433:1433 -name weighttrackerdbapp -d weighttracker:v2

# docker stop <container name>
# docker image rm <image name>:<tag name>

