<%-- 
    Document   : danger-alert
    Created on : Sep 25, 2023, 11:10:53 PM
    Author     : win
--%>
<div id="failureAlert" class="position-fixed bottom-0 right-0 p-3" style="z-index: 5; right: 0; bottom: 0;">
    <div class="alert alert-${param.type} alert-dismissible fade show" role="alert">
        <strong>${param.message}</strong>
        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
            <span aria-hidden="true">&times;</span>
        </button>
    </div>
</div>
