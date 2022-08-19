#!/bin/bash
set -e

# un-ignore build folder
sed -i 's#/build##' .gitignore
sed -i 's#build/##' .gitignore

sed -i 's#"src/\*\*/\*.ts",#"src/\*\*/\*.ts"#' tsconfig.json
TSCONFIG=$(cat tsconfig.json | jq --tab '
	.compilerOptions.outDir = "build/esm"
')
echo "$TSCONFIG" > tsconfig.json

echo "package-lock.json" >> .gitignore

PJSON=$(cat package.json | jq '
	del(.type)
	| del(.homepage)
	| .description = .description + ". This is a fork of TooTallNate/node-data-uri-to-buffer, but with CommonJS support."
	| .repository = "esm2cjs/node-data-uri-to-buffer"
	| .name |= "@esm2cjs/" + .
	| .author = { "name": "Dominic Griesel", "email": "d.griesel@gmx.net" }
	| .publishConfig = { "access": "public" }
	| .funding = "https://github.com/sponsors/AlCalzone"
	| .main = "build/cjs/index.js"
	| .types = "build/esm/index.d.ts"
	| .typesVersions = {}
	| .typesVersions["*"] = {}
	| .typesVersions["*"]["build/esm/index.d.ts"] = ["build/esm/index.d.ts"]
	| .typesVersions["*"]["build/cjs/index.d.ts"] = ["build/esm/index.d.ts"]
	| .typesVersions["*"]["*"] = ["build/esm/*"]
	| .module = "build/esm/index.js"
	| .files = ["build/esm/**/*.{js,d.ts,json}", "build/cjs/**/*.{js,d.ts,json}"]
	| .exports = {}
	| .exports["."].import = "./build/esm/index.js"
	| .exports["."].require = "./build/cjs/index.js"
	| .exports["./package.json"] = "./package.json"
	| .scripts["to-cjs"] = "esm2cjs --in build/esm --out build/cjs -t node12"
	| del(.scripts.prepublishOnly)
')
echo "$PJSON" > package.json

npm i
npm run build

npm i -D @alcalzone/esm2cjs
npm run to-cjs
npm uninstall -D @alcalzone/esm2cjs

PJSON=$(cat package.json | jq 'del(.scripts["to-cjs"])')
echo "$PJSON" > package.json

npm test
