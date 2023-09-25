# API-Platform Template

<div style="text-align:center">
  <img src="https://api-platform.com/images/super-webby.svg" alt="API-Platform Logo" width="350" height="350">
</div>

## Overview

**API-Platform Template** is a project template designed to streamline the development of REST APIs using [API Platform](https://api-platform.com/). This template includes various tools and dependencies to help you create robust APIs efficiently.

## Installation

Before you begin, make sure you have the following prerequisites:

- Docker (for local development)
- Docker compose (for local development)
- Taskfile.dev

Follow these steps to set up your development environment:

1. **Clone this Repository**:

   ```bash
   git clone https://github.com/adnanjaw/api-platform.git
   cd api-platform
   ```

2. **Start Docker Containers and Initialize the Application**:

   ```bash
   task up
   ```

   This command will:

    - Start Docker containers.
    - Install application dependencies using Composer.
    - Run database migrations.

3. **Initialize GrumPHP**:

   ```bash
   task grum:init
   ```

   This command will initialize GrumPHP, which runs code quality checks on every commit.

## Development Tools

This template includes a Taskfile that simplifies common development tasks. You can run these tasks using the `task` command:

- **Check Code Style**:

  ```bash
  task phpcs
  ```

- **Fix Code Style Issues**:

  ```bash
  task phpcs:fix
  ```

- **Lint Twig Templates**:

  ```bash
  task twigcs
  ```

- **Fix Twig Template Issues**:

  ```bash
  task twigcs:fix
  ```

- **Run PHP Mess Detector**:

  ```bash
  task phpmd
  ```

- **Run PHP Mess Detector with Strict Mode**:

  ```bash
  task phpmd:strict
  ```

- **Update PHP Mess Detector Baseline**:

  ```bash
  task phpmd:baseline
  ```

- **Run PHPStan for Static Analysis**:

  ```bash
  task phpstan
  ```

- **Update PHPStan Baseline**:

  ```bash
  task phpstan:baseline
  ```

- **Run PHPUnit Tests**:

  ```bash
  task phpunit
  ```

- **Generate PHPUnit Configuration**:

  ```bash
  task phpunit:config
  ```

## Usage

This template provides a starting point for your API development. Customize it to suit your specific project requirements. You can create API resources and configure endpoints using [API Platform documentation](https://api-platform.com/docs).

## Contributing

If you'd like to contribute to this project, please follow the standard GitHub fork-and-pull-request workflow.

## License

This template is open-source and available under the [MIT License](LICENSE).