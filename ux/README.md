# Catena-X Knowledge Agents (Hey Catena!) User Experience Sources

This is a folder linking all the codes related to the Hey Catena! (CX Knowledge Agents) User Experience product.

It consists of 
- [Skill Framework](skill_framework) library to build Apps that interact with Hey Catena! and keep conversational state.
- [Knowledge Explorer](knowledge_explorer) a set of UI components which allow an ad-hoc and speech-oriented interaction with Hey Catena! The Knowledge Explorer uses the Skill Framework.
- [Skill Gym](skill_gym) a set of UI components which allow to define and test new skills for Hey Catena! The Skill Gym uses the Skill Framework and the Knowledge Explorer

## Notice

* see copyright notice in the top folder
* see license file in the top folder
* see authors file in the top folder

## Setup as a monorepo

The CX KA UX is built in node/typescript.
The UI part is built using react.
The testing is done via jest.

* See [this guide](https://javascript.plainenglish.io/monorepo-setup-with-npm-and-typescript-90b329ba7275) on how we setup 
node in this folder.

* See [this guide](https://www.testim.io/blog/typescript-unit-testing-101/) on how we setup jest in this folder.

For initialisation, you will need to run

```
npm install -g jest
npm run init:dev
```

## Developer Workflow for the UI

At the moment the skill_gym is calling the skill_modules locally and the skill_modules implements the skill_framework. Normally the skill_modules would be built and published as a package and implemented as external npm package inside the skill_gym. To make the development progress more easy, we are linking the skill_framework and the skill_modules via npm link commands, so that those packages can be used locally. This is automatically happening when using the command:

```
npm run init:dev
```

After this happends, you can start the React app with:

```
npm run start:skillgym
```

If you want to make changes inside the skill_gym, the server will notice those changes automatically. But if you will make changes inside the skill_modules you need to build the library again with:


```
npm run build:skillm
```

The server not always notices this change automatically, in order to show the recent changes. If this happens just reload the page again.

## Code Quality

To enforce some coding conventions, we are using eslint and prettier. This rules are integrated to [Github Actions](https://github.com/catenax-ng/product-knowledge/blob/main/.github/workflows/eslint.yml) and will be checked automatically, when pushing code to the repo. If you are working with VS Code, we are highly recommend you to install the following packages:


- [EsLint](https://marketplace.visualstudio.com/items?itemName=dbaeumer.vscode-eslint)
- [Prettier](https://marketplace.visualstudio.com/items?itemName=esbenp.prettier-vscode)

Those packages will help your IDE to identify errors and warnings. If you like to enable automatic linter fixes onSave in VS Code you can add the following rules in your settings.json:

```
"editor.formatOnSaveMode": "modificationsIfAvailable",
"editor.codeActionsOnSave": {
"source.fixAll": true
},
```

Additionally you can run the linter script to check, if you have errors or warnings inside your code:

```
npm run lint
```

If the linter shows you errors and warnings, that can be fixed automatically run this command:

```
npm run lint:fix
```

...in order to let the engine fix the code for you.

