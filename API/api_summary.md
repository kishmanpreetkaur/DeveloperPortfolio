# API Integration Summary

## 1. What is a REST API?

A REST API (Representational State Transfer Application Programming Interface) allows different applications to communicate over the internet using HTTP methods. It enables users to retrieve and exchange data between systems.

## 2. HTTP Status Codes

- **200 OK:** The request was successful, and the server returned the requested data.
- **404 Not Found:** The requested resource could not be found on the server.

## 3. APIs Used

### GitHub REST API

Endpoint: `https://api.github.com/users/kishmanpreetkaur`

Purpose: Retrieves public GitHub profile information, including name, public repositories, followers, and account creation date.

Saved response: `github_profile.json`

### JSONPlaceholder API

Endpoint: `https://jsonplaceholder.typicode.com/posts`

Purpose: Retrieves sample post data for testing and practicing API requests.

Saved response: `sample_posts.json`

## 4. jq Commands Used

### Extract GitHub Profile Information

```bash
jq '{name: .name, repos: .public_repos, followers: .followers, joined: .created_at}' API/github_profile.json
```

This command extracts selected fields from the GitHub profile JSON response.

### Count JSONPlaceholder Posts

```bash
jq 'length' API/sample_posts.json
```

This command counts the number of posts returned by the API. The expected result is 100.

## 5. Conclusion

This task demonstrates how to retrieve data from REST APIs using curl, save responses in JSON files, and process JSON data using jq.
