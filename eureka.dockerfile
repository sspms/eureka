FROM registry.docker-cn.com/library/java:alpine
MAINTAINER david.du
EXPOSE 8761
COPY eureka.jar /var/lib/shanshui/eureka/eureka.jar
CMD java -jar /var/lib/shanshui/eureka/eureka.jar --spring.profiles.active=test