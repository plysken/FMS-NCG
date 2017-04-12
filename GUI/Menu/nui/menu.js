/** CONFIG **/

// !! Ici mettre le nom de la ressource !!
var resourcename = "menu";

// Nombre max d'items dans un menu 
var maxVisibleItems = 7;

/** CODE **/

var counter;
var currentpage;

var menus = [];

var container;
var content;
var maxamount;

var pageindicator = "<p id='pageindicator'></p>"

$(function() {
    container = $("#menuContainer");
    
    init();
    
    window.addEventListener("message", function(event) {
        var item = event.data;
        
        if (item.afficherMenu) {
            resetMenu();
            container.show();
            playSound("OUI");
        } else if (item.masquerMenu) {
            container.hide();
            playSound("NON");
        }
        
        if (item.menuEnter) {
            handleSelectedOption();
        } else if (item.menuBack) {
            fmenuBack();
        }
        
        if (item.menuUp) {
            fMenuUp();
        } else if (item.menuDown) {
            fMenuDown();
        }
        
        if (item.menuLeft) {
            menuPrevPage();
        } else if (item.menuRight) {
            menuNextPage();
        }
    });
});

function init() {
    $("div").each(function(i, obj) {
        if ($(this).attr("id") != "menuContainer") {
            var data = {};
            data.menu = $(this).detach();
            
            data.pages = [];
            $(this).children().each(function(i, obj) {
                // send true state if it exists
                if ($(this).data("state") == "ON") {
                    var statedata = $(this).data("action").split(" ");
                    sendData(statedata[0], {action: statedata[1], newstate: true});
                }
                
                var page = Math.floor(i / maxVisibleItems);
                if (data.pages[page] == null) {
                    data.pages[page] = [];
                }
                
                data.pages[page].push($(this).detach());
                data.maxpages = page;
            });
            
            menus[$(this).attr("id")] = data;
        }
    });
}

function fMenuUp() {
    $(".optionMenu").eq(counter).attr("class", "optionMenu");
    
    if (counter > 1) {
        counter -= 1;
    } else {
        counter = maxamount;
    }
    
    $(".optionMenu").eq(counter).attr("class", "optionMenu selected");
    playSound("NAV_UP_DOWN");
}

function fMenuDown() {
    $(".optionMenu").eq(counter).attr("class", "optionMenu");
    
    if (counter < maxamount) {
        counter += 1;
    } else {
        counter = 1;
    }
    
    $(".optionMenu").eq(counter).attr("class", "optionMenu selected");
    playSound("NAV_UP_DOWN");
}

function menuPrevPage() {
    var newpage;
    if (pageExists(currentpage - 1)) {
        newpage = currentpage - 1;
    } else {
        newpage = content.maxpages;
    }
    
    showPage(newpage);
    playSound("NAV_UP_DOWN");
}

function menuNextPage() {
    var newpage;
    if (pageExists(currentpage + 1)) {
        newpage = currentpage + 1;
    } else {
        newpage = 0;
    }
    
    showPage(newpage);
    playSound("NAV_UP_DOWN");
}

function fmenuBack() {
    if (content.menu == menus["mainmenu"].menu) {
        container.hide();
        sendData("fermetureMenu", {})
    } else {
        showMenu(menus[content.menu.data("parent")]);
    }
    
    playSound("BACK");
}

function handleSelectedOption() {
    var item = $(".optionMenu").eq(counter);
    
    if (item.data("sub")) {
        var submenu = menus[item.data("sub")];
        if (item.data("subdata")) {
            submenu.menu.attr("data-subdata", item.data("subdata"));
        } else {
            submenu.menu.attr("data-subdata", "");
        }
        
        showMenu(submenu);
    } else if (item.data("action")) {
        var newstate = true;
        if (item.data("state")) {
            // .attr() because .data() gives original values
            if (item.attr("data-state") == "ON") {
                newstate = false;
                item.attr("data-state", "OFF");
            } else if (item.attr("data-state") == "OFF") {
                item.attr("data-state", "ON");
            }
        }
        
        var data = item.data("action").split(" ");
        if (data[1] == "*") {
            data[1] = item.parent().attr("data-subdata");
        }
        
        sendData(data[0], {action: data[1], newstate: newstate});
    }
    
    playSound("SELECT");
}

function resetSelected() {
    $(".optionMenu").each(function(i, obj) {
        if ($(this).attr("class") == "optionMenu selected") {
            $(this).attr("class", "optionMenu");
        }
    });
    
    counter = 1;
    maxamount = $(".optionMenu").length - 1;
    $(".optionMenu").eq(1).attr("class", "optionMenu selected");
}

function resetMenu() {
    showMenu(menus["mainmenu"]);
}

function showMenu(menu) {
    if (content != null) {
        content.menu.detach();
    }
    
    content = menu;
    container.append(content.menu);
    
    showPage(0);
}

function showPage(page) {
    if (currentpage != null) {
        content.menu.children().detach();
    }
    
    currentpage = page;
    
    for (var i = 0; i < content.pages[currentpage].length; ++i) {
        content.menu.append(content.pages[currentpage][i]);
    }
    
    content.menu.append(pageindicator);
    
    if (content.maxpages > 0) {
        $("#pageindicator").text("Page " + (currentpage + 1) + " / " + (content.maxpages + 1));
    }
    
    resetSelected();
}

function pageExists(page) {
    return content.pages[page] != null;
}

function sendData(name, data) {
    $.post("http://" + resourcename + "/" + name, JSON.stringify(data), function(datab) {
        console.log(datab);
    });
}

function playSound(sound) {
    sendData("playsound", {name: sound});
}
