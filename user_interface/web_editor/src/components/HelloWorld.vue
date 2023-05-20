<template>
  <div>
    <div style="width: 800px; height: 800px;">
      {{ cursor_index }}
    <p
      @keydown.tab.prevent
      v-html="message"
      id="rich-text"
      style="width: 100%; white-space: pre-wrap; 
      height: 100%; background-color: aliceblue; text-align: left;"
    >
      
    </p>
    <p
      contenteditable
      @input="onInput"
      @keydown="onkeydown"
      v-html="raw"
      id="raw-text"
      style="width: 100%; 
      white-space: pre-wrap; 
      height: 100%; background-color: aliceblue; text-align: left;"
    >
      
    </p>
    </div>
  </div>

</template>

<script lang="ts">
import { defineComponent, nextTick } from 'vue';

import Vue from 'vue';

class Highlight
{

    static keywords = [
        'stateful',
        'mutation',
        'throws',
    ];

    static types = [
        'integer',
        'string',
        'datetime',
        'date',
        'boolean',
        'ownership'
    ];

    static fluyxitypes = [
        'StateMachine',
        'State',
        
        'states',
        'events',
        'transition'
    ];

    static matchStateful(input: string): RegExpMatchArray | null {
      const regex = /Entity\s+(\w+)\s*\{([\s\S]*)\}/;
      return input.match(regex);
    }

    static matchMutation(input: string): RegExpMatchArray | null {
      const pattern = /\s*mutation\s+(\w+)\s*\{([\s\S]*?)\}/;
      return input.match(pattern);
    }

    static matchThrows(input: string): RegExpMatchArray | null {
      const regex = /throws\s*\{\s*(\w+)\s*\}/;
      return input.match(regex);
    }

    static throws = [
    ];

    static get_highlighted_text(
        unhighlighted_text:string
    ) : string
    {
        
        let mutated = unhighlighted_text;

        const statefulMatch = Highlight.matchStateful(unhighlighted_text);
        if (statefulMatch) {
          console.log("Matched stateful pattern:");
          console.log(`Group 1: ${statefulMatch[1]}`);
          mutated = mutated.replaceAll(statefulMatch[1],this.mark_name(statefulMatch[1]))

          console.log(`Group 2: ${statefulMatch[2]}`);
        } else {
          console.log("No match found for stateful pattern.");
        }

        const throwsMatch = Highlight.matchThrows(unhighlighted_text);
        if (throwsMatch) {
          console.log("Matched throws pattern:");
          console.log(`Group 1: ${throwsMatch[1]}`);
          mutated = mutated.replaceAll(throwsMatch[1],this.mark_name(throwsMatch[1]))

        } else {
          console.log("No match found for throws pattern.");
        }

        var mutationMatch = Highlight.matchMutation(unhighlighted_text);
        while (mutationMatch) {
          console.log("Matched mutation pattern:");
          console.log(`Group 1: ${mutationMatch[1]}`);
          console.log(`Group 2: ${mutationMatch[2]}`);
          mutated = mutated.replaceAll(mutationMatch[1],this.mark_name(mutationMatch[1]))
          mutationMatch = Highlight.matchMutation(mutated);
        }

        // This can be optimized later, using a Double Linked List with a Stack of breakpoints.
        // But no need to prematurely optimize this.
        let highglighted_text:string = mutated;
        for(let i = 0; i < this.keywords.length; i++)
        {
            highglighted_text = highglighted_text.replaceAll(this.keywords[i],this.mark_keywords(this.keywords[i]))
        }
        for(let i = 0; i < this.types.length; i++)
        {
            highglighted_text = highglighted_text.replaceAll(this.types[i],this.mark_types(this.types[i]))
        }
        for(let i = 0; i < this.fluyxitypes.length; i++)
        {
            highglighted_text = highglighted_text.replaceAll(this.fluyxitypes[i],this.mark_fluxitypes(this.fluyxitypes[i]))
        }
        for(let i = 0; i < this.throws.length; i++)
        {
            highglighted_text = highglighted_text.replaceAll(this.throws[i],this.mark_throws(this.throws[i]))
        }
 

        return highglighted_text;
    }

    static mark_keywords( keyword:string ) : string 
    {
        return '<span style="color: #7400bc;font-weight: 500;"><b>'+keyword+'</b></span>';    
    }

    static mark_types( keyword:string ) : string 
    {
        return '<span style="color: #1904ff; font-weight: 500;">'+keyword+'</span>';    
    }
    static mark_fluxitypes( keyword:string ) : string 
    {
        return '<span style="color: #ec6e00; font-weight: 800;">'+keyword+'</span>';    
    }
    static mark_throws( keyword:string ) : string 
    {
        return '<span style="color: #f31804; font-weight: 500;">'+keyword+'</span>';    
    }
    static mark_name( keyword:string ) : string 
    {
        return '<span style="color: #f31804; font-weight: 500;">'+keyword+'</span>';    
    }
}

export default defineComponent({
  name: 'HelloWorld',
  props: {
    msg: String
  }, 
  data(){
    return {
      message: "",
      raw: "",
      cursor_index: 0
    }
  },
  methods: {
  onkeydown(e: KeyboardEvent){
    if( e.key == 'Enter' ){
      document.execCommand('insertLineBreak');
    } else if ( e.key == 'Tab' )
    {
      e.preventDefault();
      document.getElementById("raw-text")?.append("    ");
    }

      //this.message = this.message+"    ";
      
    },
  onInput(e:any) {
      this.message = Highlight.get_highlighted_text(e.target.innerText);
    }
  },
})
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped lang="scss">
h3 {
  margin: 40px 0 0;
}
ul {
  list-style-type: none;
  padding: 0;
}
li {
  display: inline-block;
  margin: 0 10px;
}
a {
  color: #f31804;
}

body {
  height: 100%;
}
</style>
