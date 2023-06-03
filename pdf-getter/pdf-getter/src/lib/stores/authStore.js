// import {} from "firebase/auth";
import {writable} from "svelte/store";
import { auth, googleProvider } from "../firebase/firebase.client";
import { signInWithPopup, signOut } from "firebase/auth";

export const authStore = writable({
  isLoading: true,
  currentUser: null
});

export const authHandlers = {
  logout: async () => {
    await signOut(auth);
  },
  signin: async () => {
    await signInWithPopup(auth, googleProvider);
    // .then(function(result) {
    //   // var token = result.credential.accessToken;
    //   var firebaseuser = result.user;

    //   if(firebaseuser) {
    //       authStore.update((curr)=>{
    //         return {...curr, isLoading: false, currentUser: firebaseuser};
    //       });
    //   }
    //   // ...
    // });
  }
};