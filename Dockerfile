# Tell Render to use the official Headwind MDM image (no build required)
FROM headwindmdm/hmdm:latest

EXPOSE 8080

# default command from the image (runs the web panel)
CMD ["java", "-jar", "/hmdm-server/hmdm.war"]
