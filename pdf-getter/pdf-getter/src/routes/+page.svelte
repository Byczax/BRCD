<script>
	import { authStore } from "$lib/stores/authStore";
  import Files from "$lib/components/Files.svelte";
	import Login from "../lib/components/Login.svelte";

  // import {Auth} from "$lib/components/Auth.svelte";
  
</script>

<form>
  <Login/>
</form>

{#if $authStore.currentUser}
  <Files/>
{/if}
<!-- <Auth/> -->