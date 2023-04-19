/********************************************************************************* 
 * Copyright (c) 2023 BMW Group AG
 * Copyright (c) 2023 Mercedes Benz AG 
 * Copyright (c) 2023 Contributors to the Eclipse Foundation
 * 
 * See the NOTICE file(s) distributed with this work for additional
 * information regarding copyright ownership.
 * 
 * This program and the accompanying materials are made available under the
 * terms of the Apache License, Version 2.0 which is available at
 * https://www.apache.org/licenses/LICENSE-2.0.
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
 * WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
 * License for the specific language governing permissions and limitations
 * under the License.
 * 
 * SPDX-License-Identifier: Apache-2.0
 ********************************************************************************/

 import React from "react";
 import Link from "@docusaurus/Link";
 import NewsTicker from "@site/src/components/NewsTicker";
 
 import styles from "./styles.module.css";
   
 export default function HomePageHeader() {
   return (
     <header className={styles.heroBanner}>
       <div className={styles.container}>
         <h2 className={styles.subtitle}>
         Welcome to Eclipse Tractus-X
         </h2>
         <h1 className={styles.title}>
         Agents Kit
         </h1>
         <div className={styles.subtitle_box}>
            We support 
            <p className={styles.subtitle}>
            Dataspace Consumers and Providers
            </p>
            to participate in semantically-driven, globally distributed 
            <p className={styles.subtitle}>
            Catena-X Use Cases
            </p>
             We support 
             <p className={styles.subtitle}>
             Service, App and Skill Providers </p>
             to develop  
             declarative logic for the <p className={styles.subtitle}>Catena-X Ecosystem
           </p>
         </div>
         <div>
         <Link className={styles.button} to="/product-knowledge/docs/adoption-view/intro">
           Adopt
          </Link>
          <Link className={styles.button} to="/product-knowledge/docs/development-view/architecture">
           Implement
          </Link>
          <Link className={styles.button} to="/product-knowledge/docs/operation-view/deployment">
           Deploy
          </Link>
         </div>
       </div>
       <NewsTicker />
     </header>
   );
 }
