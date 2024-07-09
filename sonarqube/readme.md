Afin de pouvoir lancer elastic search

1) wsl -d docker-desktop
2) sysctl -w vm.max_map_count=262144

---

Configurer le projet dans maven :

```xml
<properties>
    ...
    <sonar.projectKey>cli-api</sonar.projectKey>
    <sonar.host.url>http://localhost:9001</sonar.host.url>
    <sonar.login>_token_</sonar.login>
    <sonar.sources>src/main/java</sonar.sources>
    <sonar.tests>src/test/java</sonar.tests>
</properties>
```

Il est nécessaire aussi d'ajouter ce plugin pour utiliser les properties :

```xml
<build>
    <plugins>
        ...
        <plugin>
            <groupId>org.sonarsource.scanner.maven</groupId>
            <artifactId>sonar-maven-plugin</artifactId>
            <version>3.9.1.2184</version>
        </plugin>
    </plugins>
</build>
```

projetKey, et le login se trouve lorsque l'on crée un projet sur l'interface web de Sonar.

Commande : mvn clean verify sonar:sonar

