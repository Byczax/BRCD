<script>
  import { getStorage, ref, getMetadata, listAll, getDownloadURL } from "firebase/storage";
  import { onMount } from "svelte";
	import File from "./File.svelte";

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

<div class="card w-96 bg-base-100 shadow-xl">
  <div class="card-body">
    <h2 class="card-title">Report files</h2>
    <p>Number of files: {files.length}</p>
    
    <!-- <ul>
    </ul> -->
    <table class="table-auto">
      <thead>
        <tr>
          <th>#</th>
          <th>File name</th>
          <th>Download</th>
        </tr>
      </thead>
      <tbody>
        {#each files as f, i}
          <File file={f} index={i}/>
        {/each}
      </tbody>
    </table>
  </div>
</div>
