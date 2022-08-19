# @esm2cjs/data-uri-to-buffer

This is a fork of https://github.com/TooTallNate/node-data-uri-to-buffer, but automatically patched to support ESM **and** CommonJS, unlike the original repository.

## Install

You can use an npm alias to install this package under the original name:

```
npm i data-uri-to-buffer@npm:@esm2cjs/data-uri-to-buffer
```

```jsonc
// package.json
"dependencies": {
    "data-uri-to-buffer": "npm:@esm2cjs/data-uri-to-buffer"
}
```

but `npm` might dedupe this incorrectly when other packages depend on the replaced package. If you can, prefer using the scoped package directly:

```
npm i @esm2cjs/data-uri-to-buffer
```

```jsonc
// package.json
"dependencies": {
    "@esm2cjs/data-uri-to-buffer": "^ver.si.on"
}
```

## Usage

```js
// Using ESM import syntax
import dataUriToBuffer from "@esm2cjs/data-uri-to-buffer";

// Using CommonJS require()
const dataUriToBuffer = require("@esm2cjs/data-uri-to-buffer").default;
```

> **Note:**
> Because the original module uses `export default`, you need to append `.default` to the `require()` call.

For more details, please see the original [repository](https://github.com/TooTallNate/node-data-uri-to-buffer).

## Sponsoring

To support my efforts in maintaining the ESM/CommonJS hybrid, please sponsor [here](https://github.com/sponsors/AlCalzone).

To support the original author of the module, please sponsor [here](https://github.com/TooTallNate/node-data-uri-to-buffer).
