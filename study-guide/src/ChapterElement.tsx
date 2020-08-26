import React, {ReactNode} from 'react';

type ChapterElementProps = {
  section: Number[]
  title: string,
  children: ReactNode;
}

function ChapterElement(props: ChapterElementProps) {
  return (
    <section>
      <header>
        {props.section.join('.')} - {props.title}
      </header>
      <div>
        {props.children}
      </div>
    </section>
  );
}

export default ChapterElement;