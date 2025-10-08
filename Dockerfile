# Tell Render to use the official Headwind MDM image (no build required)
FROM headwindmdm/hmdm:latest

EXPOSE 8080
CMD ["sh", "-c", "java -Dserver.address=0.0.0.0 -Dserver.port=${PORT:-8080} -jar /hmdm-server/hmdm.war"]

