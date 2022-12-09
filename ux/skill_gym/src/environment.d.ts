//
// Environment interface for the skill gym
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//

declare global {
  namespace NodeJS {
    interface ProcessEnv {
      REACT_APP_FOLDER?: string;
    }
  }
}

// If this file has no import/export statements (i.e. is a script)
// convert it into a module by adding an empty export statement.
export {};
