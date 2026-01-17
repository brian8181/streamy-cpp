{config_load file="music.conf"}
{if isset(#enable_advanced#) && #enable_advanced# == true}
	 <li>
       <a class="Nav" href="adv_query.php">Advanced</a>
    </li>
{/if}
{if #enable_browse# == true}
	<li>
       <a class="Nav" href="browse_artist.php?nav_row=0">Browse</a>
    </li>
{/if}
{if #enable_playlist# == true}
    <li>
       <a class="Nav" href="playlists.php">Playlists</a>
     </li>
{/if}
{if #enable_statistics# == true}
	 <li>
       <a class="Nav" href="music_stats.php">Statistics</a>
     </li>
{/if}
{if #enable_quick_search# == true}
	 <li>
        <form name="toolbar" onsubmit="on_quick_submit(toolbar)" method="get" action="results.php">
          <input type="hidden" name="artist" />
          <input type="hidden" name="title" />
          <input type="hidden" name="and" value="false" />
          <div class="white" style="text-align: center">
            <strong>
              <em>Quick Search:</em>
            </strong>&nbsp;
            <input type="text" name="album" align="right"/>
          </div>
        </form>
      </li>
{/if}