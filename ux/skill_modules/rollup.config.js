import resolve from '@rollup/plugin-node-resolve';
import commonjs from '@rollup/plugin-commonjs';
import typescript from '@rollup/plugin-typescript';
import { terser } from 'rollup-plugin-terser';
import external from 'rollup-plugin-peer-deps-external';
import dts from 'rollup-plugin-dts';
import peerDepsExternal from 'rollup-plugin-peer-deps-external';
import pkg from './package.json';
import copy from 'rollup-plugin-copy';
import json from '@rollup/plugin-json';
import styles from 'rollup-plugin-styles';

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
      terser(),
      json(),
      styles(),
      copy({
        targets: [
          { src: 'src/styles/**/*', dest: 'dist/styles' },
          { src: 'src/images/**/*', dest: 'dist/images' },
          { src: 'src/sounds/**/*', dest: 'dist/sounds' },
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
