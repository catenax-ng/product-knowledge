import resolve from '@rollup/plugin-node-resolve';
import commonjs from '@rollup/plugin-commonjs';
import typescript from '@rollup/plugin-typescript';
import { terser } from 'rollup-plugin-terser';
import sass from 'rollup-plugin-sass';
import external from 'rollup-plugin-peer-deps-external';
import dts from 'rollup-plugin-dts';
import peerDepsExternal from 'rollup-plugin-peer-deps-external';
import pkg from './package.json';
import css from 'rollup-plugin-import-css';
import copy from 'rollup-plugin-copy';

export default [
  {
    input: 'src/index.ts',
    output: [
      {
        file: pkg.main,
        format: 'cjs',
        sourcemap: true,
      },
      {
        file: pkg.module,
        format: 'esm',
        sourcemap: true,
      },
    ],
    plugins: [
      peerDepsExternal(),
      external(),
      resolve(),
      commonjs(),
      css(),
      sass({}),
      terser(),
      copy({
        targets: [
          { src: 'src/styles/**/*', dest: 'dist/styles' },
          { src: 'src/images/**/*', dest: 'dist/images' },
        ],
      }),
      typescript({ tsconfig: './tsconfig.build.json' }),
    ],
    external: [...Object.keys(pkg.peerDependencies || {}), 'node-fetch'],
  },
  {
    input: 'dist/index.d.ts',
    output: [{ file: 'dist/index.d.ts', format: 'esm' }],
    external: [/\.s?ass$/, /\.css$/],
    plugins: [dts()],
  },
];
