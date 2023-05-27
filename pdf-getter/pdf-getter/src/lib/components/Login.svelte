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


<div class="form-control my-2">
  <label class="input-group input-group-md">
{#if $authStore.currentUser}
      <span>{$authStore.currentUser.displayName}</span>
      <!-- <input type="text" placeholder="Type here" class="input input-bordered input-md" /> -->
      <button class="btn btn-sm btn-primary btn-outline" on:click={handleLogout}>
        Logout with Google...
      </button>
{:else}
      <span>Not logged in</span>
      <!-- <input type="text" placeholder="Type here" class="input input-bordered input-md" /> -->
      <button class="btn btn-sm btn-primary btn-outline" on:click={handleLogin}>
        Login with Google...
      </button>
{/if}
  </label>
</div>
