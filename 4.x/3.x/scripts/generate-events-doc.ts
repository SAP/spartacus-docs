/**
 * Run with get-events.zsh
 */
import fs from 'fs';
import { ClassDeclaration, Project, SourceFile, SyntaxKind } from 'ts-morph';

const project = new Project({
  tsConfigFilePath: './tsconfig.json',
});

reportProgress('Reading files');

/**
 * Find "parent" events
 * - Events extended in other files
 */
const cxEvent = project.getSourceFileOrThrow(
  'projects/core/src/event/cx-event.ts'
);

const pageEvent = project.getSourceFileOrThrow(
  'projects/storefrontlib/src/events/page/page.events.ts'
);

// Scanning ts files in the source code excluding tests and schematics
const files = project.getSourceFiles([
  'projects/core/**/*.ts',
  'projects/storefrontlib/**/*.ts',
  '!projects/**/*.spec.ts',
  'feature-libs/**/*.ts',
  '!feature-libs/**/*.spec.ts',
  'integration-libs/**/*.ts',
  '!integration-libs/**/*.spec.ts',
]);

const cxEventName = cxEvent
  .getClasses()[0]
  .getChildrenOfKind(SyntaxKind.Identifier)[0]
  .getText();

const pageEventName = pageEvent
  .getClasses()[0]
  .getChildrenOfKind(SyntaxKind.Identifier)[0]
  .getText();

// Array of all events that can be extended
let parentEvents = [cxEventName, pageEventName];

let content = '';

reportProgress('Cataloging events');

// Check in each file if it contains an event
files.forEach((sourceFile: SourceFile) => {
  // Check all classes in the file and see if they extend an Event (CxEvent or child of)
  sourceFile.getClasses().forEach((classDeclaration: ClassDeclaration) => {
    const superClass = classDeclaration
      .getHeritageClauseByKind(SyntaxKind.ExtendsKeyword)
      ?.getTypeNodes()[0];

    if (superClass) {
      // The class extends a known event class it is an event
      if (parentEvents.includes(superClass?.getExpression()?.getText())) {
        addToContent([
          classDeclaration.getName() as string,
          getRelativeFilePath(sourceFile.getFilePath()),
        ]);

        parentEvents.push(classDeclaration.getName() as string);
      }
    }
  });
});

writeToFile(content);

/**
 * Adds a new line to the text
 * @param newText
 */
function addToContent(newText: string[]): void {
  content += '\n' + newText;
}

/**
 * Writes content to file
 * @param fileContent
 */
function writeToFile(fileContent: string) {
  reportProgress('Writing to file');
  const textToWrite = 'name,path' + fileContent;
  fs.writeFileSync('events.csv', textToWrite);
}

/**
 * Finds the name of the folder where the repository was cloned
 */
function getSpartacusRepoName(): string {
  const filePath = __filename.split('/scripts')[0].split('/');
  return filePath[filePath.length - 1];
}

/**
 * Removes trailing slash if there is one
 * @param pathToUpdate
 */
function removeFirstSlash(pathToUpdate: string): string {
  if (pathToUpdate.startsWith('/'))
    return pathToUpdate.substring(1, pathToUpdate.length);
  return pathToUpdate;
}

/**
 * Takes the absolute file path and returns the file path relative to the project root
 *
 * @param rawPath
 * @returns cleaned up path
 */
function getRelativeFilePath(rawPath: string): string {
  return removeFirstSlash(rawPath.split(getSpartacusRepoName())[1]);
}

/**
 * Log script step
 *
 * @param message step to log
 */
function reportProgress(message: string): void {
  console.log(`\n${message}`);
}
