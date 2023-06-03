<script>
	import { authStore } from "$lib/stores/authStore";
  import Files from "$lib/components/Files.svelte";
</script>

{#if $authStore.currentUser}
  <Files/>
{/if}
<!-- <Auth/> -->