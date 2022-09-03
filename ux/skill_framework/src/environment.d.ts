//
// Environment interface for the skill framework
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//

declare global {
    namespace NodeJS {
      interface ProcessEnv {
        SKILL_PROXY?: string;
        SKILL_CONNECTOR?: string;
        SKILL_CONNECTOR_AUTH_HEADER_KEY?: string;
        SKILL_CONNECTOR_AUTH_HEADER_VALUE?: string;
      }
    }
  }
  
  // If this file has no import/export statements (i.e. is a script)
  // convert it into a module by adding an empty export statement.
  export {}