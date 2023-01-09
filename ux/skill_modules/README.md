# Catena-X Skill modules

The skill modules is a set of UI components which allow to define and test new skills for the [Skill Gym](../skill_gym) and the [Knowledge Explorer](../knowledge_explorer)!

The modules uses the [Skill Framework](../skill_framework) and the [Catena-X shared component library](https://www.npmjs.com/package/cx-portal-shared-components).

If you like to reuse the modules in your own project, do the following steps:

First create a new react app and add dependencies for the library and Material UI.
We are using npm and TypeScript, if you prefer yarn or JavaScript use those.

    npm create react-app sample-skill-app --template typescript
    npm install @catenax-ng/skill-modules

Start the development server

    npm start

Edit `src/index.tsx` and add one of the available modules like "AssetView" to it.

    ReactDOM.render(
      <React.StrictMode>
        <AssetView />
      </React.StrictMode>,
      document.getElementById('app')
    );

## Components Notice

Some components need a special configuration, when using them in the consuming application.

### Custom Search

The Custom Search component uses the leaflet library, which needs the leaflet css offered by the Custom Search. To make the styles work import it in your file as followed:

    import '@catenax-ng/skill-modules/dist/styles/leaflet.css'


## Notice

- see copyright notice in the top folder
- see license file in the top folder
- see authors file in the top folder

## Available Scripts

### `npm run build`

Builds the modules and can be published after that to the github packages repository.
When you work locally and want to see the changes in the knowledge explorer - please call this command as well.
