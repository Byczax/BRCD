<script>
  import { onMount } from 'svelte'
  import { themeChange } from 'theme-change'
  //import icon component
  import {Icon} from '@steeze-ui/svelte-icon'

  //import as many icons from a Icon Pack
  import {Sun, Moon} from '@steeze-ui/heroicons'

  onMount(() => {
    themeChange(false)
  });
</script>
<label class="swap swap-flip my-3">
  
  <!-- this hidden checkbox controls the state -->
  <input type="checkbox" data-toggle-theme="halloween,fantasy"/>
  
  <div class="swap-on h-10 w-10">
    <Icon src={Sun}/>
  </div>
  
  <div class="swap-off h-10 w-10">
    <Icon src={Moon}/>
  </div>
</label>