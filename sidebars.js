/**
 * Creating a sidebar enables you to:
 - create an ordered group of docs
 - render a sidebar for each doc of that group
 - provide next/previous navigation

 The sidebars can be generated from the filesystem, or explicitly defined here.

 Create as many sidebars as you want.
 */

// @ts-check

/** @type {import('@docusaurus/plugin-content-docs').SidebarsConfig} */
const sidebars = {
    docs: [
        {
            type: 'category',
            label: 'Agents Kit',
            link: {
                type: 'generated-index',
            },
            collapsed: true,
            items: [
                'Changelog',
                {
                    type: 'category',
                    label: 'Adoption View',
                    link: {
                        type: 'doc',
                        id: 'adoption-view/intro',
                    },
                    collapsed: true,
                    items: [
                        'adoption-view/intro',
                        'adoption-view/audience',
                        'adoption-view/faq'
                    ],
                },
                {
                    type: 'category',
                    label: 'Development View',
                    link: {
                        type: 'doc',
                        id: 'development-view/architecture',
                    },
                    collapsed: true,
                    items: [
                        'development-view/architecture',
                        'development-view/modules',
                        'development-view/reference',
                        'development-view/build',
                        'development-view/compile',
                        {
                            type: 'category',
                            label: 'API',
                            link: {
                                type: 'doc',
                                id: 'development-view/api',
                            },
                            collapsed: true,
                            items: [
                                'development-view/api/agent/getAgent',
                                'development-view/api/agent/postAgent',
                                'development-view/api/agent/skill/postSkill'
                            ],
                        }
                    ],
                },
                {
                    type: 'category',
                    label: 'Operation View',
                    link: {
                        type: 'doc',
                        id: 'operation-view/deployment',
                    },
                    collapsed: true,
                    items: [
                        'operation-view/deployment',
                        'operation-view/agent_edc',
                        'operation-view/provider',
                        'operation-view/policy',
                        'operation-view/sample',
                    ],
                }

            ]
        },
    ],
};

module.exports = sidebars;