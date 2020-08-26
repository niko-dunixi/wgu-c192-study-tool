import React from 'react';
import logo from './logo.svg';
import './App.css';
import {HashRouter, Switch, Route, Link} from 'react-router-dom';
import Chapter from './Chapter';
import ChapterElement from './ChapterElement';
import SqlCode from './SqlCode';

function App() {
  return (
    <div className="App">
      <HashRouter>
        <div>
          <ul>
            <li>
              <Link to="/chapter/7">Chapter 7</Link>
            </li>
            <li>
              <Link to="/chapter/8">Chapter 8</Link>
            </li>
          </ul>
        </div>

        <Switch>
          <Route path="/chapter/7">
          <Chapter header="Chapter 7: SQL Data Definition">
            <ChapterElement
              section={[7, 1]}
              title="Identify data types that are used within a DBMS environment"
            >
              <ul>
                <li>Boolean</li>
                <ul>
                  <li>BOOLEAN</li>
                  <li>True or False</li>
                </ul>
                <li>Char</li>
                <ul>
                  <li>CHAR | VARCHAR</li>
                  <li>VARYING length = VARCHAR</li>
                  <ul>
                    <li>Used to describe up to N CHARs</li>
                  </ul>
                </ul>
                <li>Bit</li>
                <ul>
                  <li>BIT | BIT VARYING</li>
                  <li>Same as CHAR. Can be FIXED or VARYING</li>
                </ul>
                <li>Exact Numeric</li>
                <ul>
                  <li>NUMERIC | DECIMAL | INTEGER | SMALLINT | BIGINT</li>
                  <li>INT</li>
                  <ul>
                    <li>SMALLINT</li>
                    <li>BIGINT</li>
                  </ul>
                  <li>DECIMAL (or DEC)</li>
                </ul>
                <li>Approximate Numeric</li>
                <ul>
                  <li><SqlCode>FLOAT | REAL | DOUBLE PRECISION</SqlCode></li>
                </ul>
                <li><SqlCode>DATETIME</SqlCode></li>
                <ul>
                  <li><SqlCode>DATE | TIME (or WITH TIME ZONE) | TIMESTAMP (or WITH TIME ZONE)</SqlCode></li>
                </ul>
              </ul>
            </ChapterElement>
            <ChapterElement
              section={[7, 2, 2]}
              title="Domain Constraints"
            >
              <ul>
                <li>
                  Can be used implicitly when creating a table with attributes
                  or explicitly with creating a specific domain
                </li>
                <li><SqlCode>CHECK</SqlCode></li>
                <ul>
                  <li>Implicit</li>
                  <SqlCode>
                    CREATE TABLE employee_roster (
                      sex CHAR NOT NULL CHECK(sex IN('M', 'F'))
                    );
                  </SqlCode>
                  <li>Explicit</li>
                  <SqlCode multiline={true}>
                    CREATE DOMAIN SexType AS CHAR
                    DEFAULT 'M'
                    CHECK (VALUE IN ('M', 'F'));
                  </SqlCode>
                </ul>
                <li>Dropping a constraint</li>
                <SqlCode>
                  ALTER TABLE employee_roster DROP DOMAIN SexType [CASCADE | RESTRICT];
                </SqlCode>
              </ul>
            </ChapterElement>
            <ChapterElement 
              section={[7,2,3]}
              title="Entity Integrity"
            >
              <ul>
                <li>
                  Primary Key must contain unique non null value for each row
                </li>
                <li>
                  Alternate keys can be assigned a <SqlCode>UNIQUE</SqlCode> keyword, but they must be non-null
                  values and have a <SqlCode>NOT NULL</SqlCode> constraint
                </li>
              <li>
                <SqlCode multiline={true}>
                  CREATE TABLE leasing_table (
                    leaseID VARCHAR(5) NOT NULL,
                    clientID VARCHAR(5) NOT NULL,
                    propertyID VARCHAR(5) NOT NULL,
                    PRIMARY KEY (leaseID),
                    UNIQUE(clientID, propertyID)
                  );
                </SqlCode>
              </li>
              </ul>
            </ChapterElement>
            <ChapterElement
              section={[7,2,4]}
              title="Referential Integrity"
            >
              <ul>
                <li>A foreign key must refer to a non null value in a parent table</li>
                <li>
                  If there is a candidate key from the parent that is referenced in
                  any child elements, then the <SqlCode>CASCADE</SqlCode> keyword
                  must be referenced.
                </li>
                <li>
                  <SqlCode>SET NULL</SqlCode> is similar to a cascade delete, but
                  sets the referential value to null instead of deleting the row
                </li>
                <li>Implicit during creation</li>
                <SqlCode multiline={true}>
                  CREATE TABLE leasing_table(
                    leaseID VARCHAR(5) NOT NULL,
                    clientID VARCHAR(5) NOT NULL,
                    propertyID VARCHAR(5) NOT NULL,
                    <b>countryID VARCHAR(5) REFERENCES Country(countryID)</b>,
                    PRIMARY KEY (leaseID),
                    UNIQUE (clientID, propertyID)
                  );
                </SqlCode>
                <li>Explicit during alteration</li>
                <SqlCode>
                  ALTER TABLE leasing_table ADD FOREIGN KEY(countryID) REFERENCES Country(countryID)
                  [ON DELETE | ON UPDATE] [RESTRICT | CASCADE | SET NULL];
                </SqlCode>
              </ul>
            </ChapterElement>
          </Chapter>
          </Route>
          <Route path="/chapter/8">
          <Chapter header="Chapter 8: Advanced SQL">
            <ChapterElement
              section={[8.2]}
              title="Stored Procedures"
            >
              Describe a simple stored procedure
              <ul>
                <li>
                  It is a type of subprogram that can take a set of
                  parameteters and perform a set of actions
                </li>
                <li>
                  A function will always return a value or multiple
                  values, but a stored procedure is may be a `void function`
                </li>
              </ul>
            </ChapterElement>
          </Chapter>
          </Route>
        </Switch>
      </HashRouter>
    </div>
  );
}

export default App;
