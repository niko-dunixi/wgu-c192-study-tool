import React, { ReactNode } from 'react';

type ChapterProps = {
  children: ReactNode
  header: string
}

function Chapter(props: ChapterProps) {
  return (
    <section>
      <header>{props.header}</header>
      <div>
        {props.children}
      </div>
    </section>
  );
}

export default Chapter;