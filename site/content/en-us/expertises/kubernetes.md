---
title: "Your Kubernetes Experts"
layout: "company"
description: "SoKube supports you in deploying and operating your Kubernetes clusters, with the best practices you need to know to avoid the most common pitfalls."
---

{{< sokube-top-tips
    title="What are the key points of attention when deploying Kubernetes?"
    description="Deploying Kubernetes can be a complex project that involves many changes for a company. It's important to plan this migration carefully by following certain best practices to make sure everything goes smoothly. Here are a few points to keep in mind when deploying Kubernetes:"
>}}
tips:
  - icon: "pencil"
    title: "Choose the right deployment environment"
    text: "Kubernetes can be deployed in different environments, such as on-premise, on dedicated servers, or in the Cloud. It's important to choose the environment that best fits your needs in terms of performance, scalability, security, and so on."
  - icon: "network"
    title: "Set up a robust network"
    text: "Kubernetes needs a fast, reliable network to let the different parts of the cluster communicate with each other. It's important to check network performance and put fallback solutions in place in case of failure."
  - icon: "key"
    title: "Manage secrets"
    text: "Kubernetes has a notion of secrets, but it's a limited one. It's recommended to use third-party solutions to encrypt your secrets, or to use a centralized, secure solution (such as Vault). It's important to configure secrets properly and protect them against unauthorized access."
  - icon: "camera"
    title: "Monitor performance"
    text: "Kubernetes lets you monitor the performance of applications and containers in real time. It's important to configure monitoring tools and keep an eye on performance indicators to catch potential issues early and stay proactive."
  - icon: "life-ring"
    title: "Set up recovery procedures"
    text: "Kubernetes can automatically restart containers in case of failure. It's important to put recovery procedures in place to handle emergencies and critical issues."
{{< /sokube-top-tips >}}
