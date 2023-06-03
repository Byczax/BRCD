<script>
  //import icon component
  import {Icon} from '@steeze-ui/svelte-icon'

  //import as many icons from a Icon Pack
  import {ArrowDownTray} from '@steeze-ui/heroicons'

  export let file;
  export let index;
</script>
<tr>
  <td> <div class="flex items-center justify-center"> {index} </div> </td>
  <td> <div class="flex items-center justify-center"> {file.metadata.name} </div> </td>
  <td>
    <a href={file.url}  target="_blank" rel="noopener noreferrer" class="flex items-center justify-center"> 
      <Icon src={ArrowDownTray} theme='solid' size="40px" class='text-primary hover:bg-primary hover:text-accent'/>
    </a>
  </td>
</tr>