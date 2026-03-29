/**
 * Validates all *.json in /examples against glucose.reading v0.1 JSON Schema.
 */
import Ajv2020 from "ajv/dist/2020.js";
import addFormats from "ajv-formats";
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const rootDir = path.join(__dirname, "..");
const schemaPath = path.join(
  rootDir,
  "schemas",
  "jsonschema",
  "glucose.reading.v0_1.json"
);
const examplesDir = path.join(rootDir, "examples");

const rawSchema = fs.readFileSync(schemaPath, "utf8");
const schema = JSON.parse(rawSchema);

const ajv = new Ajv2020({
  allErrors: true,
  strict: false,
});
addFormats(ajv);

const validate = ajv.compile(schema);
const files = fs
  .readdirSync(examplesDir)
  .filter((name) => name.endsWith(".json"));

let failed = false;
for (const name of files) {
  const full = path.join(examplesDir, name);
  const data = JSON.parse(fs.readFileSync(full, "utf8"));
  const ok = validate(data);
  if (ok !== true) {
    failed = true;
    console.error(`FAIL ${name}`, validate.errors);
  } else {
    console.log(`OK   ${name}`);
  }
}

if (failed) {
  process.exit(1);
}
