/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/ClientSide/javascript.js to edit this template
 */

$(document).ready(function () {
    const urlParams = new URLSearchParams(window.location.search);
    const sortField = urlParams.get('field');
    const sortOrder = urlParams.get('order');

    if (sortField && sortOrder) {
        const sortableHeaders = document.querySelectorAll('.sortable[data-sort="' + sortField + '"]');
        sortableHeaders.forEach(function (header) {
            const icon = header.querySelector('i');
            icon.classList.add('fas');
            if (sortOrder === 'asc') {
                icon.classList.add('fa-sort-up');
            } else {
                icon.classList.add('fa-sort-down');
            }
            header.appendChild(icon);
        });
    }

    $('.sortable').click(function () {
        const sortField = $(this).data('sort');
        const currentUrl = window.location.href;
        const url = new URL(currentUrl);

        let sortOrder = 'asc'; // Default sort order
        if ($(this).find('i').hasClass('fa-sort-up')) {
            sortOrder = 'desc';
        }

        url.searchParams.set('field', sortField);
        url.searchParams.set('order', sortOrder);

        window.location.href = url.toString();
    });
});
