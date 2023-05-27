<script>
	import { authHandlers, authStore } from "$lib/stores/authStore";

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

{#if $authStore.currentUser}
{$authStore.currentUser.displayName}
<button class="btn btn-sm btn-primary btn-outline" on:click={handleLogout}>
  Logout with Google...
</button>

<!-- <Files/> -->
{:else}
Not logged in
<button class="btn btn-sm btn-primary btn-outline" on:click={handleLogin}>
  Login with Google...
</button>
{/if}