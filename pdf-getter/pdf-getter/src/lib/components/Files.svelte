<script>
  import { getStorage, ref, getMetadata, listAll, getDownloadURL } from "firebase/storage";
  import { onMount } from "svelte";

  const storage = getStorage();
  $: files = []; 

  function getFileData(){
    // const user = localStorage.getItem("uid");
    files = [];
    const reference = ref(storage, "reports");
    listAll(reference)
      .then((res) => {
        res.items.forEach((itemRef) => {
          getMetadata(itemRef).then((metadata) => {
            getDownloadURL(itemRef)
              .then((downloadUrl) => {
                files = [...files, {metadata, url: downloadUrl}];
              });
            
          });
        });
      });    
  }

  onMount(getFileData);
</script>

<h1>Files in firebase</h1>
<h2>Number of files: {files.length}</h2>

<ul>
  {#each files as f, i}
    <li>
      <a href={f.url}  target="_blank" rel="noopener noreferrer"> 
        f#{i+1}: {f.metadata.name}
      </a>
    </li>
  {/each}
</ul>
