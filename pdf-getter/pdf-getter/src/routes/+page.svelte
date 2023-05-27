<script>
	import { authHandlers, authStore } from "$lib/stores/authStore";
  import Files from "$lib/components/Files.svelte";

  // import {Auth} from "$lib/components/Auth.svelte";
  async function handleLogin() {
    try {
      await authHandlers.signin();
    } catch (error) {
      console.log(error);
    }
  }

  async function handleLogout() {
    try {
      await authHandlers.logout();
    } catch (error) {
      console.log(error);
    }
  }
</script>

<form>

  {#if $authStore.currentUser}
    {$authStore.currentUser.displayName}
    <button on:click={handleLogout}>
      Logout with Google...
    </button>

    <Files/>
  {:else}
    Not logged in
    <button on:click={handleLogin}>
      Login with Google...
    </button>
  {/if}
</form>
<!-- <Auth/> -->