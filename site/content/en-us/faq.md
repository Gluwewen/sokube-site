---
title: "FAQ"
layout: "simple"
---

{{< faq accentColor="text-kube-600" accentColorDark="dark:text-kube-600" menuTextColor="text-neurokube-600" menuTextColorDark="dark:text-neurokube-600" markerColor="marker:text-kube-600" markerColorDark="dark:marker:text-kube-600">}}
title: "Most frequently asked questions"
description: "Find answers to frequently asked questions about SoKube's activities."
questions:
  - category: "DevOps"
    question: "What does the term devOps mean?"
    answer: |
      The term "DevOps" is an acronym for "Development" and "Operations". 
      
      DevOps or DevSecOps is an approach, a mindset or a practice that aims to improve collaboration between development and operational teams in order to operate a software project. 
      
      This term reflects the philosophy of this methodology, which aims to bring together these two professions, often perceived as antagonistic, in order to promote better collaboration and greater efficiency.

  - category: "DevOps"
    question: "What is the difference between DevOps and DevSecOps?"
    answer: |
      The two terms are very similar. DevOps or DevSecOps is an approach, integrating a culture, practices and tools, which consists in improving communication and collaboration between developers (Dev), Quality Assurance (QA), Security (Sec), Operations (Ops) and any other department involved in the delivery of software, to help companies and organizations of all sizes and in all sectors of activity (banking, finance, industry, public authorities, associations, …) deploy new software more quickly, more efficiently and more securely.

  - category: "DevOps"
    question: "How does the DevOps/DevSecOps approach work?"
    answer: |
        Inspired by Agile development approaches, the DevOps / DevSecOps concept emphasizes enhanced collaboration between developers and operations team members (system administrators, operations, ...) to optimize code delivery, testing and production infrastructure.

        For greater agility, developers and operators work on small software and infrastructure updates that are released independently of each other. 
        To deploy application code structured in microservices, DevOps teams use CI (Continuous Integration), CD (Continuous Delivery) and container technologies such as Docker, Kubernetes, OpenShift, etc. (on-premise or in the cloud), which are essential to ensure the consistency of deployment and hosting environments, but also to optimize the management of security, scalability and resilience of applications.
        Observability also plays a very important role, via logging, metrics and tracing, to always have a complete view of the system.
        Also, the problems identified during the production phase lead to improvements in the code, through a continuous feedback cycle.

        This is called the DevOps feedback loop or DevOps 8:

        ![The DevOps / DevSecOps infinity loop: plan, code, build, test, release, deploy, operate, monitor](/images/devops-devsecops-loop.png)

  - category: "DevOps"
    question: "What is a DevOps / DevSecOps team?"
    answer: |
        A DevOps / DevSecOps team is composed of employees from the Development (project manager, developer, …), Security, Deployment (IT engineer, system administrators, …) and any other team involved in the software lifecycle who work together to improve communication and collaboration between the two disciplines. The objective is to allow development and deployment teams to work better together in order to accelerate the development and deployment cycle of software applications while making it more reliable!

  - category: "DevOps"
    question: "What is a DevOps / DevSecOps engineer?"
    answer: |
        A DevOps engineer must understand the DevOps / DevSecOps philosophy but also the tools and software that make it up. So this implies understanding the development, security, production and operability perspectives. 

        He must have some expertise in automation, Infra-as-Code, continuous integration, deployment, container orchestration, security, observability, …. He/she works in collaboration with the various development and infrastructure teams to improve the application development and delivery processes while ensuring stability and security.

  - category: "DevOps"
    question: "What is the life cycle of a DevOps / DevSecOps approach?"
    answer: |
        Aimed at improving the productivity of the development life cycle of a software application, the DevOps / DevSecOps approach can be imagined as an infinite loop, comprising 8 repeating steps

        1. **Planning**: In a first step, the team identifies the requirements and needs of the end-users (customers, management or internal users) and works on writing a specification and an associated development schedule in order to identify the MVP (Minimum Viable Product), i.e. the version of a software that allows to obtain a maximum of returns with a minimum of effort, then to build a backlog following the agile methods

        2. **Code creation**: At this stage, the teams proceed with the actual development of the application by following Agile iterations by Sprint.

        3. **Construction (Build)**: Once the development tasks are completed, the code is deposited in a shared repository (Git Repository) and we then proceed to a continuous integration (CI) phase allowing us to compile the source code, validate the quality of the code, package the application, carry out the different levels of testing (Unit Tests, Integration Tests, System Tests, … ), build the docker image, validate the good practices, make sure there are no critical vulnerabilities in the image and deploy the image in an artifact manager.

        4. **Versioning**: Versioning can be done in several ways and can be automatically done with an auto-versioning approach. Once the testing phase is completed and successful, the Build is prepared by the DevOps engineers to be deployed in the production environment. 

        5. **Test**: It is possible to have a test phase to validate the behavior of the application in an integration environment (as close as possible to Production) where integration tests, user interface automation, as well as manual tests, such as user acceptance tests, are then performed.

        6. **Deployment**: At this stage, the build is deployed, tested and implemented in production to be available to end users.

        7. **Operation**: The IT infrastructure people orchestrate the design, implementation, configuration, deployment and maintenance steps to ensure the seamless availability of the developed software application.

        8. **Monitoring**: DevOps teams monitor each release and write technical and functional recommendations to improve future software releases. 

        To speed up application release time and ensure version compliance, IT teams use CI/CD pipelines and other automation to move code from one development and deployment stage to another. 

  - category: "DevOps"
    question: "Why do DevOps: The benefits of the approach?"
    answer: |
        The implementation of a DevOps approach allows you to improve several fundamental points. Here are the main benefits you can get from it.

        **Faster software delivery**
        With a CI/CD pipeline, deployment is faster and more frequent. It takes less time to update existing services and deploy new systems, features or bug fixes. This can also provide a significant competitive advantage and a better user experience.

        **Improved Collaboration**
        With DevOps practices, developers and operations teams work closely together, with shared responsibilities, which increases visibility into the work. More connected, the teams are all working towards the same goals.

        **Better productivity**
        With improved communication, the right tools and a prioritized development process, teams work more efficiently.

        **Automation of repetitive tasks**
        Automating repetitive tasks is one of the most important aspects of DevOps, allowing development and operations teams to focus on higher-value tasks and reduce human error.

        **Increased Quality and Reliability**
        Continuous integration and delivery practices ensure that changes are functional and stable, which improves the quality of a software product. Monitoring also allows teams to stay on top of performance in real time.

        **Better security**
        By adopting a “Security as Code” approach early in the development cycle, it is easier to better identify and fix potential vulnerabilities before software is released to production.

        **More frequent releases**
        Customers can receive updates and bug fixes more frequently, which also translates into better customer satisfaction.
  
  - category: "DevOps"
    question: "Which tools to choose to implement a DevOps approach?"
    answer: |
        DevOps tools make repetitive tasks in the software development lifecycle easier and more automated. They also help teams collaborate efficiently and track changes to code over time.

        Some of the most popular tools include Puppet, Kubernetes, Docker, Chef, Ansible, SaltStack and Jenkins.

  - category: "DevOps"
    question: "What is Azure DevOps?"
    answer: |
        Azure DevOps is an online collaboration platform that enables development teams to manage the entire development lifecycle of a project, from coding to delivery. Azure DevOps offers a wide range of services to support development teams and enable them to reliably and securely deliver their projects.

  - category: "DevOps"
    question: "What are the challenges related to the implementation of a DevOps approach?"
    answer: |
        The implementation of a DevOps approach can be complex and challenging for companies. Indeed, it is necessary to take into account several factors such as the company culture, existing processes, tools used, etc.
        The training of the collaborators is one of the points of vigilance to be taken into account to mitigate a possible deficiency of the members of a team relating to the methodology of project management or the control of the tools used.

        To this effect, a DevOps training course allows to acquire the necessary skills to implement a DevOps approach in your company.

  - category: "Agile approach"
    question: "What is an Agile framework?"
    answer: |
        An Agile framework translates into a state of mind (values and principles) and practices. The whole supports value creation efficiency as well as operational effectiveness. By putting the end-user at the center of the development team’s concerns, by ensuring an empirical approach supporting a principle of continuous improvement, the Agile framework ensures the meaning of the collective action of the collaborators.

  - category: "Agile approach"
    question: "What are the characteristics of an Agile framework?"
    answer: |
        - Leadership and collaborative dynamics
        - Product vision & value creation assumptions
        - Iterative and incremental development
        - Continuous improvement, learning & user feedback

  - category: "Agile approach"
    question: "What is the Agile Manifesto?"
    answer: |
        Written by a group of developers in 2001, the Agile manifesto aims to modernize, make reliable and accelerate software application development processes through the implementation of 12 development principles, based on 4 values.

        The Agile manifesto, when embodied in a software development process, translates the state of mind that gives meaning to the fundamental Agile principles of collaboration, communication, self-organization and the ambition to always better satisfy the expectations of users & end customers through the rapid and regular delivery of application features. 

        To know more about this:
        - https://agilemanifesto.org/iso/fr/manifesto.html
        - https://agilemanifesto.org/iso/fr/principles.html

  - category: "Agile approach"
    question: "What are the 4 values of the Agile manifesto?"
    answer: |
        1. People and their interactions rather than processes and tools
        2. Operational software more than exhaustive documentation
        3. Collaboration with customers more than contractual negotiation
        4. Adapting to change more than following a plan

  - category: "Agile approach"
    question: "What are the main challenges when implementing an Agile framework?"
    answer: |
        - **Why**: Establishing the reason for change
        - **For What**: Change the culture, not just adopt practices
        - **Who**: Engage all stakeholders involved in the transformation
        - **What**: Ensure that daily work is simplified and meaningful
        - **How**: Identify and implement sustainable, autonomous, multidisciplinary Product teams 

  - category: "Agile approach"
    question: "When should you implement an Agile framework in your organization?"
    answer: |
        In a [“VUCA” context](https://en.wikipedia.org/wiki/Volatility,_uncertainty,_complexity_and_ambiguity) or a complex context from the point of view of [Stacey’s matrix](https://www.wikiberal.org/wiki/Matrice_de_Stacey), empirical approaches are more effective. In fact, in a context where any problem encountered can find its source in multiple causes, it is advisable to advance step by step and to confront with reality what we think is the best solution. The decision can only be made after experimentation and knowledge acquisition.

  - category: "Agile approach"
    question: "How to start an Agile approach?"
    answer: |
        First, we need to clearly define why we want to change. Moving an organization towards an Agile approach is not an objective in itself. We must therefore agree on the organizational performance objective.

        Then, instead of a global transformation mainly involving the use of Agile practices, it is preferable to work on the implementation of an iterative and incremental approach evolving the culture of the organization, simplifying the daily work and aligning this work with the organization’s strategy.

  - category: "Agile approach"
    question: "What is Scrum?"
    answer: |
        Scrum [by Scrum.org](https://www.scrum.org/) and [by Scrum Alliance](https://www.scrumalliance.org/) is a framework that implements the values and principles of the Agile Manifesto. Through 3 roles, 3 artifacts and 5 rituals, this framework allows multidisciplinary and autonomous teams to focus on the iterative realization of a “Product” value increment. Its implementation is supported by 5 values (courage, focus, openness, respect and commitment) and an empirical approach to continuous improvement.

  - category: "Agile approach"
    question: "What is a Scrum Master?"
    answer: |
        The Scrum Master is one of the 3 roles of the Scrum framework. Basically, his main goal is to help the Scrum team to improve. To do this, he is the guarantor of the respect of the Scrum framework by the team. As a trainer, facilitator, coach and mentor, he is in charge of addressing the obstacles that the Scrum team encounters and is an agent of change within the organization.

  - category: "Agile approach"
    question: "What does the notion of Scrum artifact mean?"
    answer: |
        The three Scrum artifacts (Product Backlog, Sprint Backlog and Increment) are intended to help the team manage its work (prioritization by value, planning and progress tracking). Thus, all the stakeholders involved in the product can see what the team is accomplishing. Other Agile practices, such as the Sprint goal, the Burndown Chart and the Definition of Completion, enrich the Scrum agile framework when the context requires it.

  - category: "Agile approach"
    question: "What is the Kanban approach, when and why use it?"
    answer: |
        The Kanban framework, which has its roots in Lean and TPS (Toyota Production System) approaches, brings together a set of Agile practices that aim to optimize the value creation flow. Based on visual management, Kanban focuses on reducing work in progress, decreasing waiting times to accelerate the Time to Market, the time that separates the consideration of a need and its implementation within a user experience.

  - category: "Agile approach"
    question: "What is Extreme programming (XP)"
    answer: |
        XP is an Agile framework that reflects a software development style that emphasizes excellence in programming techniques, simple and effective communication (3C) and the search for the simplest possible solutions. This translates into proven software development values and practices such as Peer Programming, Collective Code Ownership, Test Driven Development and Continuous Integration.

  - category: "Agile approach"
    question: "What is the Scaled Agile Framework® (SAFe®)?"
    answer: |
        [SAFe](https://www.scaledagileframework.com/) is an agility scaling framework that integrates many Lean, Agile and DevOps practices. It offers several possible configurations to adapt to the different levels of complexity of organizations. Its implementation aims at aligning the efforts of 50 to 125 collaborators on the same value creation intention, the Agile Release Trains or ART. SAFe is also characterized by new roles and rituals (RTE & PI Planning).

  - category: "Agile approach"
    question: "What are the benefits of implementing an Agile framework?"
    answer: |
        The main benefits of an Agile framework are: 
        - Focus on creating value for the end user
        - Optimize the operational process through an empirical approach supporting continuous improvement (Be more efficient)
        - Favour innovation by amplifying collaborative dynamics and collective intelligence

  - category: "Agile approach"
    question: "What is the Spotify model?"
    answer: |
        The Spotify Model reflects an organizational structure pattern of agility at scale implemented within Spotify. It is composed of Tribes, Squads, Chapters and Guilds. It aims to optimize delivery, information flow and skill/knowledge sharing within the organization. Keep in mind that Spotify has built this model for its own needs and not to encourage other companies to apply the same model. Henrik Kniberg, Agile coach at Spotify, said that the path that led Spotify to this model is much more important than the model itself.

  - category: "Agile approach"
    question: "What is the VSM (Value Stream Mapping) approach?"
    answer: |
        A value chain represents the sequence of activities that an organization must perform to design, implement and deliver a customer request. It involves a dual flow of information and material. Value Stream Mapping provides a holistic and measured view of how the value creation flow is operated within an organization. It is a very effective practice for establishing strategic decisions for organizational optimization.

  - category: "Agile approach"
    question: "What is Lean thinking?"
    answer: |
        Lean thinking reflects an approach to improving organizations through 5 main principles: 
        1. Specify precisely the value created for a given product;
        2. Identify the value chain of each product;
        3. Eliminate all possible interruptions in the value creation flow;
        4. Ensure that customer demand triggers value creation;
        5. And be part of a quest for perfection through a continuous improvement process.

  - category: "Agile approach"
    question: "What is Lean Startup (Eric Ries)?"
    answer: |
        Lean Startup is characterized by the rapid and inexpensive validation of value creation hypotheses. This approach translates into the realization of an MVP (Minimum Viable Product) and an iterative learning cycle (Build – Measure – Learn) that leads to a decision making process such as: Continue – Pivot – Abandon.

  - category: "Agile approach"
    question: "What are OKRs (Objectives & Key Results)?"
    answer: |
        OKRs are an approach to formalizing objectives and key results in order to align an organization’s operational efforts with its strategic intentions. Each objective (strategic or operational) reflects the qualification of a goal to be achieved, while the key results reflect the quantification of the achievement of a particular objective. Key results are used to evaluate the progress made in achieving the objective, through a cycle of OKRs lasting 3 months.

  - category: "Kubernetes"
    question: "What is Kubernetes?"
    answer: |
        Kubernetes, also known as Kube or K8s (pronounced “Kates”), is an open source container orchestration platform. Originally developed by Google, Kubernetes automates the deployment, scaling and management of containerized applications, in private, public and hybrid cloud environments.
        Integrated in March 2016 by the Cloud Native Computing Foundation (CNCF), part of the non-profit Linux Foundation, Kubernetes is classified as a Graduated project token of an overall level of maturity especially in terms of diversity of contribution and community adoption.

  - category: "Kubernetes"
    question: "How does Kubernetes work?"
    answer: |
        Kubernetes automatically manages the varying needs of each container running on a group of servers or “cluster” by dynamically allocating the required resources.

        Through probes, Kube is for example able to determine if your application needs to be restarted, needs to be moved to another node (to better manage resource capacities) or if it is necessary to create one or more additional instances to better manage the load. 

        All k8s behaviors are described through YAML or JSON files ingested by a control center that informs and triggers the necessary actions.

        Kubernetes continually seeks to reconcile the desired state, described by these YAML files, with the actual state of what is deployed.

  - category: "Kubernetes"
    question: "What architecture to implement to support Kubernetes?"
    answer: |
        A Kubernetes cluster architecture is generally broken down into 2 parts: The control center (Server API, Scheduler, the Controllers and the base etcd) called “Control Plane” or “Master Nodes” or “Server Nodes” and the working nodes called the “Worker Nodes” or “Agent Nodes”.

        The nodes can be VMs (Virtual Machine) or physical servers in which the containers represented by a logical notion: the Pod, run.

        The Server API is the central point of all administrative communications of the cluster allowing us to interact with it via commands and Manifest files (in YAML or JSON) which will be interpreted by the Controllers to ensure that the k8s objects are created and correspond to the desired state which is stored in the Kubernetes database called ETCD.
        The Scheduler is in charge of deploying the pods on the right kube nodes according to the availability of resources (CPU, RAM,…) and the placement constraints that have been defined.

        The “Worker Nodes” or “Agent Nodes” contain, in addition to the application pods, 2 important components which are Kubelet and Kube-proxy. 

        Kubelet is the component that monitors, stops and starts the containers, it receives these instructions from the Scheduleur and the Controllers through the Server API.
        Kube-proxy is a network proxy that manages network communications inside and outside the cluster. 

  - category: "Kubernetes"
    question: "How to deploy a Kubernetes cluster?"
    answer: |
        Kubernetes is composed of different elements (server API, a scheduleur, controllers, a base etcd, kubelet, kube-proxy,…) which are each binaries that must be deployed on VMs or physical machines.

        Depending on the Kubernetes on-premise distributions ([Vanilla](https://kubernetes.io/), [RedHat OpenShift](https://www.redhat.com/en/technologies/cloud-computing/openshift), [Rancher RKE ou K3S](https://www.rancher.com/), [VMWare Tanzu](https://tanzu.vmware.com/), [D2iQ](https://d2iq.com/), [Nutanix Karbon](https://www.nutanix.com/products/karbon), …) or Kubernetes cloud managed ([Amazon EKS](https://aws.amazon.com/eks/), [Microsoft AKS](https://azure.microsoft.com/en-us/products/kubernetes-service/), [Google GKE](https://cloud.google.com/kubernetes-engine), [Exoscale Kubernetes](https://www.exoscale.com/sks/), [OVHcloud Kubernetes](https://www.ovhcloud.com/en/public-cloud/), …) | the installation and configuration steps are different.

        These installations or configurations can be done via IaC (Infra-as-Code) tools such as [Ansible](https://www.ansible.com/) or [Terraform](https://www.terraform.io/), via custom scripts or more recently via the Cluster API (CAPI) allowing to manage the complete cycle of a k8s cluster.

  - category: "Kubernetes"
    question: "What is the role of a Kubernetes Pod?"
    answer: |
        A pod is the smallest unit of resources deployable on a single node, sharing resources such as storage and network access. 
        A pod is therefore a logical definition that can contain 1 or more application containers sharing storage resources as well as the same network identity (IP address) plus a number of configurations that influence how the containers run.

  - category: "Kubernetes"
    question: "What is a Kubernetes cluster?"
    answer: |
        A cluster is a set of nodes, or work machines, on which containerized applications run. These nodes can be physical machines or virtual machines.

  - category: "Kubernetes"
    question: "What is the difference between Kubernetes and Docker?"
    answer: |
        Docker is a company that develops, among other things, a product of the same name that allows to build and run containers in a unitary way on a machine.

        Kubernetes is positioned above as an orchestrator of containers to manage the life cycle of a set of containers on several machines (virtual or physical).
        For this Kubernetes relies on the [« Runtime specification of Open Container Initiative »](https://github.com/opencontainers/runtime-spec) with 2 flagship implementations : [Containerd](https://containerd.io/) and [CRI-O](https://cri-o.io/).

        When we compare Docker and Kubernetes we often talk about “Pet vs Cattle” to express the difference in treatment between a pet for which it has a name, a place of residence, that is treated with great care and livestock that is managed in a more industrial way.

  - category: "Kubernetes"
    question: "What is the difference between Kubernetes and distributions like Openshift, Rancher or Tanzu?"
    answer: |
        [Kubernetes](https://kubernetes.io/fr/docs/concepts/overview/what-is-kubernetes/) is an open-source system of which there are several implementations.

        On-premise implementations like :
        - [Vanilla](https://kubernetes.io/) : this is the basic open-source distribution
        - [RedHat OpenShift](https://www.redhat.com/en/technologies/cloud-computing/openshift)
        - [Rancher RKE ou K3S](https://www.rancher.com/)
        - [VMWare Tanzu](https://tanzu.vmware.com/)
        - [Nutanix Karbon](https://www.nutanix.com/products/karbon)
        - [D2iQ](https://d2iq.com/)
        - …
 
        Or managed cloud implementations such as:
        - [Amazon EKS](https://aws.amazon.com/eks/)
        - [Microsoft AKS](https://azure.microsoft.com/en-us/products/kubernetes-service/)
        - [Google GKE](https://cloud.google.com/kubernetes-engine)
        - [Exoscale Kubernetes](https://www.exoscale.com/sks/)
        - [OVHcloud Kubernetes](https://www.ovhcloud.com/en/public-cloud/)
        - …
 
        These lists are by no means exhaustive but represent a good part of the current market.
        Note also that all these distributions are certified by the
        [Cloud Native Computing Foundation (CNCF)](https://www.cncf.io/), the foundation that manages Kubernetes.

  - category: "Kubernetes"
    question: "What are the features of Redhat's Kubernetes OpenShift release?"
    answer: |
        Unlike Kubernetes, an open source project, the Red Hat OpenShift solution is a commercial product requiring a paid subscription contract.

        In addition to a support service, the Red Hat OpenShift solution includes a version of the Kubernetes project certified by the Cloud Native Computing Foundation, with a set of additional components and services oriented towards enterprise solutions with a strong security focus.

        It includes CI/CD pipelines (Tekton project), a GitOps solution (ArgoCD), a Service Mesh (Istio), an observability solution (Promotheus, Grafana, EFK), serverless and virtualization functions and many other features.
        
        Learn more about Red Hat OpenShift:
        https://www.redhat.com/fr/technologies/cloud-computing/openshift/features 

  - category: "Kubernetes"
    question: "Why deploy Kubernetes?"
    answer: |
        Designed to aggregate and run applications, containers must be managed to avoid service outages. 

        Implementing Kubernetes enables resilient management of distributed container-based systems and a highly available architecture.

        For example, Kubernetes enables load balancing and network traffic distribution to stabilize the deployment during traffic spikes. 

        In addition, Kubernetes offers the ability to deploy and operate cloud-native applications regardless of the environment whether you are hosted on a public cloud (such as Google Cloud, AWS or Microsoft Azure), private cloud or on a local architecture.

        Kubernetes also manages the ability to automate the return to a stable environment, to restart failed containers, to stop those that do not offer the desired level of performance.
        Kubernetes is today a de facto standard that brings a homogeneous and standard way to deploy and manage containers. Because of the way it is declared and operates, it is also a solution that facilitates the implementation of DevOps or DevSecOps approaches.

  - category: "Kubernetes"
    question: "Can all applications run in kubernetes?"
    answer: |
        In theory a container can run any application and be orchestrated by Kubernetes.

        In practice, things are more complicated because in order to take full advantage of Kubernetes features such as scalability, high availability, observability, security, … it is necessary to architect and develop your applications in a certain way, this is what we call Cloud Native Applications (CNA).

        For cost reasons, it is not always possible to completely redesign an application but it is possible to adapt it to make it a “Cloud Ready Application”.

        Legacy applications can be contained with little effort to at least benefit from the standard deployment of a container and the management of its lifecycle without, for example, taking advantage of scaling…

  - category: "Kubernetes"
    question: "What are the benefits offered by Kubernetes?"
    answer: |
        From the perspective of optimizing an environment with cloud-native applications, the main benefit of the Kubernetes solution is really the automated orchestration of containers and the elimination of the human factor. In addition, the fact that only the master server is administered and not each node individually makes it easier to use and saves significant time while limiting the risk of associated errors.

        The automation of elastic allocation of additional resources (autoscaling), dynamic traffic management, redundancy, resilience, provided by a Kubernetes platform can meet the challenges of industrialization of IT departments while ensuring the agility of operations and business (reliability and acceleration of the “time to market” of applications).

        Finally, the portability of Kubernetes offers real independence from platforms and therefore from Cloud operators, making it easy to change providers. Kubernetes, which is totally in line with a DevOps approach, is therefore positioned as the reference container orchestrator, bringing a de facto standard to the management of the entire container lifecycle from development to production. 

  - category: "Kubernetes"
    question: "What future for Kubernetes?"
    answer: |
        The [Cloud Native Computing Foundation (CNCF)](https://www.cncf.io/) has owned the Kubernetes project since 2016 which is considered a “Graduated” project (the highest level of maturity of CNCF projects).

        Through this foundation, Kubernetes evolves regularly by offering new versions every 4 months bringing either stability or new features.

        K8s is becoming more and more important in companies of all sizes and allows to meet more and more varied needs. The creation of multiple clusters should become a commodity whether On-prem, Multi-Cloud or Hybrid-cloud all with “platform” approaches for large scale deployments. Areas such as VM virtualization in Kube, MLOps (Machine Learning), AI (Artificial Intelligence) or Blockchain are likely to become more and more important.

{{< /faq >}}
