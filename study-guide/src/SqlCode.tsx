import React, { ReactNode } from 'react';

type SqlCodeProps = {
  children: ReactNode;
  multiline?: boolean
}

function SqlCode(props: SqlCodeProps) {
  if (props.multiline) {
    return (
      <pre>
      <code>
        {props.children}
      </code>
      </pre>
    )
  }
  return (
    <code>
      {props.children}
    </code>
  )
}

export default SqlCode;