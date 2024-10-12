

```md
# EasyGPT

## 项目介绍

**EasyGPT** 是一个基于 **Spring Cloud** 的微服务架构项目，提供轻量化的 GPT 模型交互能力。通过云原生技术构建，开发者可以快速集成和部署 GPT 驱动的对话应用，享受高扩展性和稳定的微服务架构。

## 主要功能

- ☁️ **微服务架构**：基于 Spring Cloud，模块化设计，方便扩展和维护。
- 🔗 **API 网关**：统一路由和负载均衡管理，轻松处理多服务请求。
- 🔍 **服务发现**：自动服务注册与发现（Nacos 或 Eureka）。
- 💬 **GPT 服务**：集成 GPT API，提供智能对话接口。
- 📊 **负载均衡**：使用 Ribbon 或 Spring Cloud LoadBalancer 提供高效的负载分发。
- 🔐 **安全认证**：支持 OAuth2 或 JWT，保证访问安全。
- 🔄 **容错机制**：集成 Resilience4j 或 Hystrix，增强服务的稳定性。

## 系统架构

EasyGPT 的架构设计遵循微服务架构原则，核心组件包括：

1. **API 网关服务**：通过 Spring Cloud Gateway 实现路由分发与负载均衡。
2. **服务注册中心**：通过 Nacos 或 Eureka 管理微服务的注册和发现。
3. **GPT 处理服务**：与 OpenAI GPT 模型进行交互，处理用户的自然语言请求。
4. **用户管理服务**：负责用户信息的认证与授权。
5. **日志监控服务**：使用 Spring Cloud Sleuth 和 Zipkin 进行分布式跟踪和日志管理。

## 环境要求

- **JDK 17** 或更高版本
- **Maven 3.8+**
- **Docker** （可选，容器化部署）
- **Nacos** 或 **Eureka** （服务注册与发现）
- **Redis** （可选，用于缓存）

## 安装步骤

1. **克隆项目**：

   ```bash
   git clone https://github.com/yourusername/easygpt.git
   cd easygpt
   ```

2. **配置文件**：

   在 `application.yml` 或 `bootstrap.yml` 中设置 API 密钥、服务地址等配置，或者将配置托管到 Nacos 中。

3. **启动微服务**：

   分别启动每个微服务：

   ```bash
   cd api-gateway
   mvn spring-boot:run

   cd ../gpt-service
   mvn spring-boot:run

   cd ../user-service
   mvn spring-boot:run
   ```

   或者使用 Docker Compose 一键启动：

   ```bash
   docker-compose up --build
   ```

## 配置示例

每个微服务都有独立的 `application.yml` 配置文件。以下是部分示例：

- **API 网关配置** (`api-gateway`)：
  ```yaml
  server:
    port: 8080

  spring:
    cloud:
      gateway:
        routes:
          - id: gpt-service
            uri: lb://GPT-SERVICE
            predicates:
              - Path=/gpt/**
          - id: user-service
            uri: lb://USER-SERVICE
            predicates:
              - Path=/user/**
  ```

- **服务注册中心配置** (`nacos-server` 或 `eureka-server`)：
  ```yaml
  server:
    port: 8848

  spring:
    cloud:
      nacos:
        discovery:
          server-addr: localhost:8848
  ```

## 使用示例

项目启动后，可以通过 API 网关访问各个服务：

- **GPT 服务接口**：`http://localhost:8080/gpt/chat`
- **用户服务接口**：`http://localhost:8080/user/profile`

示例请求：

```bash
curl -X POST http://localhost:8080/gpt/chat \
     -H "Content-Type: application/json" \
     -d '{"message": "你好，GPT！"}'
```

## 日志和监控

项目集成了 **Zipkin** 进行分布式链路跟踪，启动后可通过以下步骤进行监控：

1. **启动 Zipkin**：

   ```bash
   docker run -d -p 9411:9411 openzipkin/zipkin
   ```

2. **访问 Zipkin UI**：

   在浏览器中访问 `http://localhost:9411`，查看微服务的调用链路。

## 贡献指南

欢迎任何形式的贡献！无论是问题反馈、新功能建议还是代码提交，都可以通过 Pull Request 向我们提交。

## 开源协议

本项目基于 MIT 许可证开源，详细信息请参阅 [LICENSE](LICENSE) 文件。


