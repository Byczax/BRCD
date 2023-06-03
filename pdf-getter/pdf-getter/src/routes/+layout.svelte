<script>
    import "$lib/styles/global.css";
    import {onMount} from "svelte";
    import {auth} from "$lib/firebase/firebase.client";
    import {authStore} from "$lib/stores/authStore";
	import Login from "../lib/components/Login.svelte";
	import ColorSwitcher from "../lib/components/ColorSwitcher.svelte";
    onMount(() => {
        const unsubscribe = auth.onAuthStateChanged((user)=>{
            console.log(user);
            authStore.update((curr) => {
                return { ...curr, isLoading: false, currentUser: user};
            })
        });
    });
</script>
<main class="flex items-center justify-center flex-col m-5">
    <h2 class="text-4xl font-extrabold text-center">BRCD FILE SERVICE</h2>
    <Login/>
    <slot/>
    <ColorSwitcher/>
</main>