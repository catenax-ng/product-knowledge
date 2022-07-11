---
sidebar_position: 2
title: Architecture
---

## High Level Architecture
![Architecture High-Level](/img/knowledge_agent_architecture.png)

## Component Architecture
The logical and technical architecture consists of three modules:
- Ontology-Based Semantic Model and EDC Federated Data Catalogue
- EDC-Compatible Agent Backends
   - Provider Agent 
   - Inference Agent
   - Function Agent
- EDC-Compatible UX components
  - Skill (Consumer) Framework 
  - Knowledge Explorer
  - Skill Development Environment

## Technology Stack
- Provider-Side Programming Language: Java > 12
  - Eclipse Dataspace Connector
  - Provider Agent: OnTop
  - Inference Agent: Fuseki
  - Function Agent: ...
- Consumer-Side Programming Language: Typescript
  - Skill Framework: React/Redux
  - Knowledge Explorer: React/Redux & Catena-X Portal
  - Skill Development Environment: React/Redux & Catena-X Portal